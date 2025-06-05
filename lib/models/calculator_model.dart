import '../utils/calculator_logic.dart';

class CalculatorModel {
  double _num1 = 0; // First operand
  double _num2 = 0; // Second operand
  String _operator = ''; // Current operator
  String _display = '0'; // Current display value
  String _calculation = ''; // Ongoing calculation (e.g., "2 + 2")
  bool _isOperatorPressed = false; // Tracks if an operator was pressed
  bool _isResultDisplayed = false; // Tracks if result is shown
  final List<String> _history = []; // Store last 10 calculations

  // Getters
  String get display => _display;
  String get calculation => _calculation;
  List<String> get history => List.unmodifiable(_history); // Read-only history

  // Reset calculator
  void reset() {
    _num1 = 0;
    _num2 = 0;
    _operator = '';
    _display = '0';
    _calculation = '';
    _isOperatorPressed = false;
    _isResultDisplayed = false;
  }

  // Handle backspace
  void backspace() {
    if (_display.isNotEmpty && _display != '0' && !_isResultDisplayed) {
      _display =
          _display.length > 1
              ? _display.substring(0, _display.length - 1)
              : '0';
    }
  }

  // Process input
  String processInput(String value) {
    if (value == 'AC') {
      reset();
    } else if (value == '⌫') {
      backspace();
    } else if (value == '=') {
      if (_operator.isNotEmpty) {
        try {
          _num2 = double.parse(_display);
          double result = _calculate();
          if (result.isInfinite || result.isNaN) {
            _display = 'Infinity';
            _calculation = '';
          } else {
            _display = CalculatorLogic.formatNumber(
              result,
            ); // Use new formatting
            _calculation = '$_num1 $_operator $_num2 =';
            // Add to history
            _addToHistory('$_num1 $_operator $_num2 = $_display');
            _num1 = result;
            _operator = '';
            _isResultDisplayed = true;
          }
        } catch (e) {
          _display = 'Error';
          _calculation = '';
        }
      }
    } else if (['+', '−', '×', '÷', '%'].contains(value)) {
      if (_operator.isNotEmpty && !_isOperatorPressed) {
        // Chain calculations
        try {
          _num2 = double.parse(_display);
          double result = _calculate();
          if (result.isInfinite || result.isNaN) {
            _display = 'Error';
            _calculation = '';
            return 'Error';
          }
          // Add intermediate result to history
          _addToHistory(
            '$_num1 $_operator $_num2 = ${CalculatorLogic.formatNumber(result)}',
          );
          _num1 = result;
          _display = CalculatorLogic.formatNumber(result); // Use new formatting
        } catch (e) {
          _display = 'Error';
          _calculation = '';
          return 'Error';
        }
      } else {
        _num1 = double.tryParse(_display) ?? 0;
      }
      _operator = value;
      _calculation = '$_num1 $_operator';
      _isOperatorPressed = true;
      _isResultDisplayed = false;
    } else {
      // Handle digits and decimal
      if (_isResultDisplayed) {
        _display = value;
        _calculation = '';
        _isResultDisplayed = false;
      } else if (_isOperatorPressed || _display == '0') {
        _display = value;
        _isOperatorPressed = false;
      } else {
        if (value == '.' && _display.contains('.'))
          return _display; // Prevent multiple decimals
        _display += value;
      }
      if (_operator.isNotEmpty) {
        _calculation = '$_num1 $_operator $_display';
      }
    }
    return _display;
  }

  // Perform calculation
  double _calculate() {
    switch (_operator) {
      case '+':
        return _num1 + _num2;
      case '−':
        return _num1 - _num2;
      case '×':
        return _num1 * _num2;
      case '÷':
        return _num2 != 0 ? _num1 / _num2 : double.infinity;
      case '%':
        return _num2 != 0 ? _num1 % _num2 : double.infinity; // Modulo operation
      default:
        return 0;
    }
  }

  // Add calculation to history (limit to 10)
  void _addToHistory(String calculation) {
    if (_history.length >= 10) {
      _history.removeAt(0); // Remove oldest if history is full
    }
    _history.add(calculation);
  }
}
