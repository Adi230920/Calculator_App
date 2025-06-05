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
    // Determine if this is the '=' button to apply special styling
    bool isEqualsButton = text == '=';

    return ElevatedButton(
      onPressed: () => onPressed(text),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            color ??
            const Color.fromARGB(255, 15, 15, 15), // White or orange for '='
        foregroundColor: const Color.fromARGB(255, 14, 13, 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side:
              isEqualsButton
                  ? BorderSide
                      .none // No border for '=' button
                  : const BorderSide(
                    color: AppConstants.equalsColor, // Orange border
                    width: 2.0,
                  ),
        ),
        elevation: 10, // Flat design, no shadow
        padding: const EdgeInsets.all(AppConstants.buttonPadding),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: AppConstants.buttonFontSize,
          fontWeight: FontWeight.bold,
          color:
              Colors
                  .white, // Ensure text is white (overrides foregroundColor if needed)
        ),
      ),
    );
  }
}
