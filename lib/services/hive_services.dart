// lib/services/hive_service.dart
import 'package:hive/hive.dart';
import '../models/budget.dart';
import '../models/expense.dart';
import '../models/savings_goal.dart';

class HiveService {
  static const String budgetBoxName = 'budgetBox';
  static const String expenseBoxName = 'expenseBox';
  static const String savingsGoalBoxName = 'savingsGoalBox';

  /// Initialize Hive
  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(BudgetAdapter().typeId)) {
      Hive.registerAdapter(BudgetAdapter());
    }
    if (!Hive.isAdapterRegistered(ExpenseAdapter().typeId)) {
      Hive.registerAdapter(ExpenseAdapter());
    }
    if (!Hive.isAdapterRegistered(SavingsGoalAdapter().typeId)) {
      Hive.registerAdapter(SavingsGoalAdapter());
    }

    await Hive.openBox<Budget>(budgetBoxName);
    await Hive.openBox<Expense>(expenseBoxName);
    await Hive.openBox<SavingsGoal>(savingsGoalBoxName);
  }

  /// Budget Methods
  Budget? getBudget() {
    var box = Hive.box<Budget>(budgetBoxName);
    return box.isNotEmpty ? box.getAt(0) : null;
  }

  Future<void> saveBudget(Budget budget) async {
    var box = Hive.box<Budget>(budgetBoxName);
    if (box.isEmpty) {
      await box.add(budget);
    } else {
      await box.putAt(0, budget);
    }
  }

  Future<void> clearBudget() async {
    await Hive.box<Budget>(budgetBoxName).clear();
  }

  /// Expense Methods
  List<Expense> getExpenses() {
    return Hive.box<Expense>(expenseBoxName).values.toList();
  }

  Future<void> addExpense(Expense expense) async {
    await Hive.box<Expense>(expenseBoxName).add(expense);
  }

  Future<void> deleteExpense(int index) async {
    await Hive.box<Expense>(expenseBoxName).deleteAt(index);
  }

  Future<void> clearExpenses() async {
    await Hive.box<Expense>(expenseBoxName).clear();
  }

  /// Savings Goal Methods
  List<SavingsGoal> getSavingsGoals() {
    return Hive.box<SavingsGoal>(savingsGoalBoxName).values.toList();
  }

  Future<void> addSavingsGoal(SavingsGoal goal) async {
    await Hive.box<SavingsGoal>(savingsGoalBoxName).add(goal);
  }

  Future<void> updateSavingsGoal(int index, SavingsGoal updatedGoal) async {
    await Hive.box<SavingsGoal>(savingsGoalBoxName).putAt(index, updatedGoal);
  }

  Future<void> deleteSavingsGoal(int index) async {
    await Hive.box<SavingsGoal>(savingsGoalBoxName).deleteAt(index);
  }

  Future<void> clearSavingsGoals() async {
    await Hive.box<SavingsGoal>(savingsGoalBoxName).clear();
  }
}
