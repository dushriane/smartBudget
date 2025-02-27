import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';
import 'expense_card.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseProvider); // 👈 Watch Riverpod state

    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return ExpenseCard(
          title: expense.title,
          amount: "${expense.amount} RWF",
          date: expense.date.toString(), // 👈 Convert DateTime to string
        );
      },
    );
  }
}
