import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;
  final Color? color;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppConstants.buttonColor, // White or orange
        foregroundColor: AppConstants.textColor, // Black text
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25), // Minimal rounding
        ),
        elevation: 0, // Flat design, no shadow
        padding: const EdgeInsets.all(AppConstants.buttonPadding),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: AppConstants.buttonFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
