import 'package:flutter/material.dart';
import 'calcButton.dart';

class ButtonGrid extends StatelessWidget {
  final List<List<String>> buttons;
  final void Function(String) onButtonPressed;

  const ButtonGrid({
    super.key, 
    required this.buttons,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buttons.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((buttonText) {
              return Expanded(
                child: CalcButton(
                  text: buttonText,
                  onPressed: () => onButtonPressed(buttonText),
                  backgroundColor: Colors.grey,
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}