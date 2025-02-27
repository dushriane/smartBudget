import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/savings_goal.dart';

// Savings state model
final savingsProvider = StateNotifierProvider<SavingsNotifier, List<SavingsGoal>>((ref) {
  return SavingsNotifier();
});

class SavingsNotifier extends StateNotifier<List<SavingsGoal>> {
  SavingsNotifier() : super([]) {
    _loadSavingsGoals();
  }

  //final Ref ref;

  // Load savings goals from Hive (or SharedPreferences)
  Future<void> _loadSavingsGoals() async {
    final box = await Hive.openBox<SavingsGoal>('savingsBox');
    final storedGoals = box.values.toList();
    state = storedGoals;
  }

  // Compute total savings goal amount
  double get savings => state.fold(0, (sum, goal) => sum + goal.savedAmount);

  // Add a savings goal
  Future<void> addGoal(SavingsGoal savingsGoal) async {
    final box = await Hive.openBox<SavingsGoal>('savingsBox');
    await box.add(savingsGoal);
    state = List.from(state)..add(savingsGoal); // Update the state
  }

  // Remove a savings goal
  Future<void> removeGoal(SavingsGoal goal) async {
    final box = await Hive.openBox<SavingsGoal>('savingsBox');
    await box.delete(goal.id);  // Using Hive key to delete the specific goal
    state = state.where((g) => g != goal).toList();  // Update state by removing goal
  }

  // Check if the savings goal is reached
  bool isGoalReached(double currentAmount, SavingsGoal goal) {
    return currentAmount >= goal.targetAmount;
  }

  // Update savings goal if necessary
  Future<void> updateGoal(SavingsGoal goal, double newAmount) async {
    final box = await Hive.openBox<SavingsGoal>('savingsBox');
    await box.put(goal.id, goal.copyWith(targetAmount: newAmount)); // Update with new amount
    state = List.from(state)..add(goal); // Refresh the state
  }
}
