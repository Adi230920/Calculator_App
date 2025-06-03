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
      builder:
          (context) => AlertDialog(
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
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 7, 14), // Gray background
      body: SafeArea(
        child: Column(
          children: [
            // Display area
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppConstants.displayPadding),
              color: const Color.fromARGB(255, 15, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Ongoing calculation
                  Text(
                    _model.calculation,
                    style: TextStyle(
                      fontSize: AppConstants.calculationFontSize,
                      color: const Color.fromARGB(
                        255,
                        252,
                        250,
                        250,
                      ).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 150),
                  // Current input/result
                  Text(
                    _model.display,
                    style: TextStyle(
                      fontSize: AppConstants.displayFontSize,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 250, 246, 246),
                    ),
                  ),
                ],
              ),
            ),
            // Button grid (4x5 to match the image)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppConstants.gridSpacing),
                child: GridView.count(
                  crossAxisCount: 4, // 4 columns to match the image
                  crossAxisSpacing: AppConstants.gridSpacing,
                  mainAxisSpacing: AppConstants.gridSpacing,
                  children:
                      AppConstants.buttonLabels.map((label) {
                        return CalculatorButton(
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

  // Determine button color based on label
  Color _getButtonColor(String label) {
    if (label == 'H') return AppConstants.historyColor;
    if (['AC', '%', '÷', '×', '−', '+'].contains(label))
      return AppConstants.operatorColor;
    if (label == '=') return AppConstants.equalsColor;
    return AppConstants.buttonColor;
  }
}
