import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../models/calculator_model.dart';
import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorModel _model = CalculatorModel();

  // Show history dialog
  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Calculation History'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: _model.history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _model.history[_model.history.length -
                        1 -
                        index], // Reverse order (latest first)
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor, // Gray background
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.displayPadding),
              color: AppConstants.displayBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Ongoing calculation
                  Text(
                    _model.calculation,
                    style: TextStyle(
                      fontSize: AppConstants.calculationFontSize,
                      color: AppConstants.textColor.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Current input/result
                  Text(
                    _model.display,
                    style: TextStyle(
                      fontSize: AppConstants.displayFontSize,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor,
                    ),
                  ),
                ],
              ),
            ),
            // Action buttons (AC, Backspace, History)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.gridSpacing,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    AppConstants.actionButtonLabels.map((label) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: CalculatorButton(
                            text: label,
                            onPressed: (value) {
                              setState(() {
                                if (value == 'H') {
                                  _showHistoryDialog();
                                } else {
                                  _model.processInput(value);
                                }
                              });
                            },
                            color: _getActionButtonColor(label),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            // Button grid
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppConstants.gridSpacing),
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: AppConstants.gridSpacing,
                  mainAxisSpacing: AppConstants.gridSpacing,
                  children:
                      AppConstants.buttonLabels.map((label) {
                        return CalculatorButton(
                          text: label,
                          onPressed: (value) {
                            setState(() {
                              _model.processInput(value);
                            });
                          },
                          color: _getButtonColor(label),
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Determine button color for main grid
  Color _getButtonColor(String label) {
    if (['+', '-', '*', '/'].contains(label)) return AppConstants.operatorColor;
    if (label == '=') return AppConstants.equalsColor;
    return AppConstants.buttonColor;
  }

  // Determine button color for action buttons
  Color _getActionButtonColor(String label) {
    if (label == 'H') return AppConstants.historyColor;
    return AppConstants.clearColor;
  }
}
