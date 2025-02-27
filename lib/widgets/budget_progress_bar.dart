import 'package:flutter/material.dart';

class BudgetProgressBar extends StatelessWidget {
  final double totalBudget; // The total budget amount
  final double currentSpending; // The amount spent so far

  const BudgetProgressBar({
    super.key,
    required this.totalBudget,
    required this.currentSpending,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentSpending / totalBudget;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress > 1 ? 1.0 : progress, // Prevent value > 1
          minHeight: 8,
          color: progress > 0.8
              ? Colors.red
              : progress > 0.5
              ? Colors.orange
              : Colors.green,
          backgroundColor: Colors.grey[300],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${currentSpending.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              '\$${totalBudget.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
