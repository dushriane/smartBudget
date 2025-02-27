import 'package:hive/hive.dart';

part "budget.g.dart";

@HiveType(typeId: 1) // Unique type ID for Hive
class Budget extends HiveObject {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final double spent;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime endDate;

  Budget({
    required this.amount,
    required this.spent,
    required this.startDate,
    required this.endDate,
  });

  /// Calculate remaining budget
  double get remaining => amount - spent;

  /// Check if budget is exceeded
  bool get isExceeded => spent > amount;

  /// Update spent amount
  Budget copyWith({double? spent}) {
    return Budget(
      amount: amount,
      spent: spent ?? this.spent,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
