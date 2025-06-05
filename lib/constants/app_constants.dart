import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color backgroundColor = Color(0xFF6E7A85); // Gray background
  static const Color buttonColor = Colors.white; // White buttons
  static const Color operatorColor = Colors.white; // Operators same as digits
  static const Color clearColor = Colors.white; // Clear button
  static const Color equalsColor = Color(0xFFFFA500); // Orange equals button
  static const Color historyColor = Colors.grey; // History button color
  static const Color displayBackground = Color(
    0xFFD3DCE6,
  ); // Light gray display
  static const Color textColor = Colors.black; // Black text on buttons/display

  // Sizes
  static const double buttonFontSize = 20.0; // Smaller font size
  static const double displayFontSize = 40.0; // Slightly smaller display
  static const double calculationFontSize = 20.0; // Smaller calculation text
  static const double buttonPadding =
      10.0; // Reduced padding for smaller buttons
  static const double gridSpacing = 8.0; // Slightly tighter spacing
  static const double displayPadding = 15.0; // Reduced display padding

  // Button labels (4x5 grid matching the image)
  static const List<String> buttonLabels = [
    'AC',
    '⌫',
    '%',
    '÷',
    '7',
    '8',
    '9',
    '×',
    '4',
    '5',
    '6',
    '−',
    '1',
    '2',
    '3',
    '+',
    'H',
    '0',
    '.',
    '=',
  ];
}
