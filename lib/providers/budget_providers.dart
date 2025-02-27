import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/budget.dart';

final budgetProvider = StateNotifierProvider<BudgetNotifier, Budget?>((ref) {
  return BudgetNotifier(ref);
});

class BudgetNotifier extends StateNotifier<Budget?> {
  BudgetNotifier(this.ref) : super(null) {
    _loadBudget();
  }

  final Ref ref;

  // Load budget from Hive
  Future<void> _loadBudget() async {
    var box = await Hive.openBox<Budget>('budgetBox');
    state = box.get('budget', defaultValue: Budget(amount: 0, spent: 0, startDate: DateTime.now(), endDate: DateTime.now().add(Duration(days: 30))));
  }

  // Set budget value
  Future<void> setBudget(Budget budget) async {
    var box = await Hive.openBox<Budget>('budgetBox');
    await box.put('budget', budget);
    state = budget;
  }

  // Check if the user has exceeded the budget
  bool isOverBudget(double currentTotal) {
    return state != null && currentTotal > state!.amount;
  }
}
