import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const Color backgroundColor = Color(0xFF6E7A85); // Gray background
  static const Color buttonColor = Colors.white; // White buttons
  static const Color operatorColor = Colors.white; // Operators same as digits
  static const Color clearColor = Colors.white; // Clear/backspace buttons
  static const Color equalsColor = Color(0xFFFFA500); // Orange equals button
  static const Color historyColor = Colors.grey; // History button color
  static const Color displayBackground = Color(
    0xFFD3DCE6,
  ); // Light gray display
  static const Color textColor = Colors.black; // Black text on buttons/display

  // Sizes
  static const double buttonFontSize = 24.0;
  static const double displayFontSize = 48.0;
  static const double calculationFontSize = 24.0;
  static const double buttonPadding = 20.0;
  static const double gridSpacing = 10.0;
  static const double displayPadding = 20.0;

  // Button labels (main grid)
  static const List<String> buttonLabels = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '+',
    '=',
  ];

  // Additional buttons (AC, Backspace, History)
  static const List<String> actionButtonLabels = [
    'AC', '⌫', 'H', // H for History
  ];
}
