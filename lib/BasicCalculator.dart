import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = "0";
  String operation = "";

  void calculate(String op) {
    try {
      double num1 = double.parse(num1Controller.text);
      double num2 = double.parse(num2Controller.text);
      setState(() {
        operation = op;
        switch (op) {
          case 'ADD':
            result = (num1 + num2).toStringAsFixed(2);
            break;
          case 'SUBTRACT':
            result = (num1 - num2).toStringAsFixed(2);
            break;
          case 'MULTIPLY':
            result = (num1 * num2).toStringAsFixed(2);
            break;
          case 'DIVIDE':
            if (num2 != 0) {
              result = (num1 / num2).toStringAsFixed(2);
            } else {
              result = "Cannot divide by zero";
            }
            break;
        }
      });
    } catch (e) {
      setState(() {
        result = "Invalid input";
      });
    }
  }

  Widget buildCalculatorButton(String text, VoidCallback onPressed) {
    return Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildNumberInput(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Basic Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Result Display
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        result,
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      if (operation.isNotEmpty)
                        Text(
                          'Operation: $operation',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),

                // Input Fields
                buildNumberInput('Enter first number', num1Controller),
                buildNumberInput('Enter second number', num2Controller),

                SizedBox(height: 20),

                // Operation Buttons
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    buildCalculatorButton('ADD', () => calculate('ADD')),
                    buildCalculatorButton('SUBTRACT', () => calculate('SUBTRACT')),
                    buildCalculatorButton('MULTIPLY', () => calculate('MULTIPLY')),
                    buildCalculatorButton('DIVIDE', () => calculate('DIVIDE')),
                  ],
                ),

                // Clear Button
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        num1Controller.clear();
                        num2Controller.clear();
                        result = "0";
                        operation = "";
                      });
                    },
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}