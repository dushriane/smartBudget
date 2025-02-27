import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/budget.dart';
import '../models/savings_goal.dart';
import '../providers/budget_providers.dart';
import '../providers/savings_provider.dart';

class BudgetSavingsScreen extends ConsumerWidget {
  const BudgetSavingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = ref.watch(budgetProvider);
    final savingsGoals = ref.watch(savingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Budget & Savings')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBudgetSection(context, ref, budget),
            SizedBox(height: 20),
            _buildSavingsSection(context, ref, savingsGoals),
          ],
        ),
      ),
    );
  }

  /// Budget Section
  Widget _buildBudgetSection(BuildContext context, WidgetRef ref, Budget? budget) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Monthly Budget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(budget != null ? "\$${budget.amount}" : "No budget set"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _showBudgetDialog(context, ref),
              child: Text('Set Budget'),
            ),
          ],
        ),
      ),
    );
  }

  /// Savings Section
  Widget _buildSavingsSection(BuildContext context, WidgetRef ref, List<SavingsGoal> savingsGoals) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Savings Goals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          savingsGoals.isEmpty
              ? Text("No savings goals set.")
              : Expanded(
            child: ListView.builder(
              itemCount: savingsGoals.length,
              itemBuilder: (context, index) {
                final goal = savingsGoals[index];
                return ListTile(
                  title: Text(goal.title),
                  subtitle: Text("Target: \$${goal.targetAmount} | Saved: \$${goal.savedAmount}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => ref.read(savingsProvider.notifier).removeGoal(goal),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _showSavingsDialog(context, ref),
            child: Text('Add Savings Goal'),
          ),
        ],
      ),
    );
  }

  /// Dialog to Set Budget
  void _showBudgetDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController budgetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Set Monthly Budget'),
          content: TextField(
            controller: budgetController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter amount'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                double? amount = double.tryParse(budgetController.text);
                if (amount != null) {
                  ref.read(budgetProvider.notifier).setBudget(Budget(amount: amount, spent: 0, startDate: DateTime.now(), endDate: DateTime.now().add(Duration(days: 30))));
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  /// Dialog to Add Savings Goal
  void _showSavingsDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Savings Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Goal Name')),
              TextField(controller: targetController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'Target Amount')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                double? targetAmount = double.tryParse(targetController.text);
                if (targetAmount != null) {
                  ref.read(savingsProvider.notifier).addGoal(SavingsGoal(title: nameController.text, targetAmount: targetAmount, savedAmount: 0, deadline: DateTime.now().add(Duration(days: 30))));
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
