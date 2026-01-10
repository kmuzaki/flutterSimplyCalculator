import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'calcButton.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = '';
  String _result = '0';

  void _onButtonPressed(String value) {
    setState(() {
      switch (value) {
        case 'C':
          _expression = '';
          _result = '0';
          break;
        case '⌫':
          if (_expression.isNotEmpty) {
            _expression = _expression.substring(0, _expression.length - 1);
          }
          break;
        case '=':
          _calculateResult();
          break;
        default:
          _expression += value;
      }
    });
  }

  void _calculateResult() {
    try {
      // Replace display symbols with math symbols
      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100');

      Parser parser = Parser();
      Expression exp = parser.parse(finalExpression);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);

      // Format result: remove trailing zeros for whole numbers
      if (eval == eval.toInt()) {
        _result = eval.toInt().toString();
      } else {
        _result = eval.toStringAsFixed(8).replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
      }
    } catch (e) {
      _result = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Display area
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Expression
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _expression.isEmpty ? '0' : _expression,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Result
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(
                      _result,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          // Button grid
          Expanded(
            flex: 4,
            child: _buildButtonGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonGrid() {
    final buttons = [
      ['C', '⌫', '%', '÷'],
      ['7', '8', '9', '×'],
      ['4', '5', '6', '-'],
      ['1', '2', '3', '+'],
      ['00', '0', '.', '='],
    ];

    return Column(
      children: buttons.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((buttonText) {
              return Expanded(
                child: CalcButton(
                  text: buttonText,
                  onPressed: () => _onButtonPressed(buttonText),
                  backgroundColor: Colors.grey,
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  // Widget _buildButton(String text) {
  //   // Determine button type for styling (adjust colors later)
  //   bool isOperator = ['÷', '×', '-', '+', '='].contains(text);
  //   bool isSpecial = ['C', '⌫', '%'].contains(text);

  //   return Padding(
  //     padding: const EdgeInsets.all(4.0),
  //     child: ElevatedButton(
  //       onPressed: () => _onButtonPressed(text),
  //       style: ElevatedButton.styleFrom(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         // TODO: Customize these colors
  //         backgroundColor: isOperator
  //             ? Colors.green
  //             : isSpecial
  //                 ? Colors.grey[300]
  //                 : Colors.grey[100],
  //         foregroundColor: isOperator ? Colors.white : Colors.black,
  //       ),
  //       child: Text(
  //         text,
  //         style: const TextStyle(fontSize: 24),
  //       ),
  //     ),
  //   );
  // }
}