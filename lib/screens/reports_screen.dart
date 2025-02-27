import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseProvider);
    final categoryTotals = _calculateCategoryTotals(expenses.cast<Expense>());

    return Scaffold(
      appBar: AppBar(title: Text('Reports & Graphs')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Spending Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: _buildPieChart(categoryTotals)),
            SizedBox(height: 20),
            Text('Monthly Expense Trends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: _buildBarChart(expenses.cast<Expense>())),
          ],
        ),
      ),
    );
  }

  /// Calculate total spending per category
  Map<String, double> _calculateCategoryTotals(List<Expense> expenses) {
    Map<String, double> totals = {};
    for (var expense in expenses) {
      totals[expense.category] = (totals[expense.category] ?? 0) + expense.amount;
    }
    return totals;
  }

  /// Pie Chart for Category-wise Spending
  Widget _buildPieChart(Map<String, double> categoryTotals) {
    return PieChart(
      PieChartData(
        sections: categoryTotals.entries.map((entry) {
          return PieChartSectionData(
            value: entry.value,
            title: entry.key,
            color: Colors.primaries[categoryTotals.keys.toList().indexOf(entry.key) % Colors.primaries.length],
            radius: 50,
          );
        }).toList(),
      ),
    );
  }

  /// Bar Chart for Monthly Spending Trends
  Widget _buildBarChart(List<Expense> expenses) {
    return BarChart(
      BarChartData(
        barGroups: expenses.map((expense) {
          return BarChartGroupData(
            x: expense.date.day,
            barRods: [
              BarChartRodData(
                toY: expense.amount,
                color: Colors.blueAccent,
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
