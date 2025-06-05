class CalculatorLogic {
  // Format number: integers without decimals, decimals with full precision
  static String formatNumber(double number) {
    if (number == number.toInt()) {
      return number.toInt().toString(); // Display integers without decimals
    } else {
      return number.toString(); // Display decimals with full precision
    }
  }
}
