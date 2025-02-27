import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/models/expense.dart';
import 'package:untitled/models/savings_goal.dart';
import '../models/budget.dart';
import '../providers/expense_provider.dart';
import '../providers/budget_providers.dart';
import '../providers/savings_provider.dart';
import '../widgets/expense_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalExpenses = ref.watch(expenseProvider).totalExpenses;
    final budget = ref.watch(budgetProvider) ?? Budget(amount: 0, spent: 0, startDate: DateTime.now(), endDate: DateTime.now().add(Duration(days: 30)));
    final savings = ref.watch(savingsProvider).savings;
    final expenses = ref.watch(expenseProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Smart Budget Tracker')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOverviewCard('Total Expenses', totalExpenses, Colors.red),
            _buildOverviewCard('Budget', budget as double, Colors.blue),
            _buildOverviewCard('Savings', savings, Colors.green),
            SizedBox(height: 20),
            Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: expenses.isEmpty
                  ? Center(child: Text('No transactions yet'))
                  : ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index]; // Get one expense from the list

                  return ExpenseCard(
                    title: expense.title,
                    amount: "${expense.amount} RWF",
                    date: expense.date.toString(), // Convert DateTime to string
                  );
                },
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addExpense'),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewCard(String title, double amount, Color color) {
    return Card(
        color: color.withAlpha((0.2 * 255).toInt()), // Fix deprecated withOpacity(),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text('\$${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, color: color)),
      ),
    );
  }
}

extension on List<Expense> {
   get totalExpenses => null;
}

extension on List<SavingsGoal> {
   get savings => null;
}
