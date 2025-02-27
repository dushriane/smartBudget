import 'package:hive/hive.dart';

part 'savings_goal.g.dart';

@HiveType(typeId: 2)
class SavingsGoal {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double targetAmount;

  @HiveField(3)
  final double savedAmount;

  @HiveField(4)
  final DateTime deadline;

  @HiveField(5)
  final bool isCompleted;

  SavingsGoal({
    this.id,
    required this.title,
    required this.targetAmount,
    required this.savedAmount,
    required this.deadline,
    this.isCompleted = false,
  });

  /// Update saved amount
  SavingsGoal copyWith({double? savedAmount, bool? isCompleted, required double targetAmount}) {
    return SavingsGoal(
      id: id,
      title: title,
      targetAmount: targetAmount,
      savedAmount: savedAmount ?? this.savedAmount,
      deadline: deadline,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
