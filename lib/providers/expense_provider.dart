import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/expense.dart';  // Import the Expense model

// Expense state model
final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  return ExpenseNotifier();
});

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]) {
    _loadExpenses();
  }

  // Load expenses from Hive
  Future<void> _loadExpenses() async {
    var box = await Hive.openBox<Expense>('expenseBox');
    state = box.values.toList();  // Load all expenses from the box
  }

  // Compute total expenses
  double get totalExpenses => state.fold(0, (sum, expense) => sum + expense.amount);

  // Add a new expense
  Future<void> addExpense(Expense expense, double amount, String selectedCategory) async {
    var box = await Hive.openBox<Expense>('expenseBox');
    await box.add(expense);  // Add the expense to the box
    state = box.values.toList();  // Update the state with the latest list of expenses
  }

  // Remove an expense by index
  Future<void> removeExpense(int index) async {
    var box = await Hive.openBox<Expense>('expenseBox');
    await box.deleteAt(index);  // Remove the expense from the box
    state = box.values.toList();  // Update the state with the latest list of expenses
  }
}
