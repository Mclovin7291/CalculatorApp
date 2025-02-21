import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '0';
  String _firstNumber = '';
  String _operator = '';
  bool _isNewNumber = true;

  void _onNumberPressed(String number) {
    setState(() {
      if (_isNewNumber) {
        _display = number;
        _isNewNumber = false;
      } else {
        _display = _display + number;
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      _firstNumber = _display;
      _operator = operator;
      _isNewNumber = true;
    });
  }

  void _onEqualsPressed() {
    setState(() {
      double result;
      double num1 = double.parse(_firstNumber);
      double num2 = double.parse(_display);

      switch (_operator) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '×':
          result = num1 * num2;
          break;
        case '÷':
          result = num1 / num2;
          break;
        default:
          return;
      }

      _display = result.toString();
      _isNewNumber = true;
      _operator = '';
      _firstNumber = '';
    });
  }

  void _onClearPressed() {
    setState(() {
      _display = '0';
      _firstNumber = '';
      _operator = '';
      _isNewNumber = true;
    });
  }

  Widget _buildButton(String text, VoidCallback onPressed, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            padding: const EdgeInsets.all(20.0),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        children: [
          // Display placeholder
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: const Text(
              '0',
              style: TextStyle(fontSize: 48.0),
            ),
          ),
          // Buttons
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('7', () => _onNumberPressed('7')),
                    _buildButton('8', () => _onNumberPressed('8')),
                    _buildButton('9', () => _onNumberPressed('9')),
                    _buildButton('÷', () => _onOperatorPressed('÷'), color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', () => _onNumberPressed('4')),
                    _buildButton('5', () => _onNumberPressed('5')),
                    _buildButton('6', () => _onNumberPressed('6')),
                    _buildButton('×', () => _onOperatorPressed('×'), color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', () => _onNumberPressed('1')),
                    _buildButton('2', () => _onNumberPressed('2')),
                    _buildButton('3', () => _onNumberPressed('3')),
                    _buildButton('-', () => _onOperatorPressed('-'), color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', () => _onNumberPressed('0')),
                    _buildButton('C', _onClearPressed, color: Colors.red),
                    _buildButton('=', _onEqualsPressed, color: Colors.blue),
                    _buildButton('+', () => _onOperatorPressed('+'), color: Colors.orange),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
