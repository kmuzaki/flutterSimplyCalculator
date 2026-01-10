import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const CalcButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool isOperator = ['÷', '×', '-', '+', '='].contains(text);
    bool isSpecial = ['C', '⌫', '%'].contains(text);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: isOperator
              ? Colors.blueAccent
              : isSpecial
                  ? Colors.grey[300]
                  : Colors.grey[100],
          foregroundColor: isOperator ? Colors.white : Colors.black,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}