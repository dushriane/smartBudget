import 'package:hive/hive.dart';

late Box boxBudget;        // Stores budget data
late Box boxExpenses;      // Stores user expenses
late Box boxCategories;    // Stores expense categories
late Box boxSavings;       // Stores savings goals
late Box boxSettings;      // Stores app settings (dark mode, currency, etc.)

/// Function to initialize all Hive boxes
Future<void> initHiveBoxes() async {
  boxBudget = await Hive.openBox('budgetBox');
  boxExpenses = await Hive.openBox('expensesBox');
  boxCategories = await Hive.openBox('categoriesBox');
  boxSavings = await Hive.openBox('savingsBox');
  boxSettings = await Hive.openBox('settingsBox');
}
