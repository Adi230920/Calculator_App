class CalculatorLogic {
  // Format number to remove trailing zeros
  static String formatNumber(double number) {
    return number.toStringAsFixed(2).replaceAll('.00', '');
  }
}
