import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/boxes.dart';
import 'services/notification_services.dart';
import 'screens/home_screen.dart'; // Import HomeScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and all necessary boxes
  await Hive.initFlutter();
  await initHiveBoxes(); // Ensure your Hive boxes are initialized

  // Initialize notification service
  await NotificationService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Smart Expense and Budgeting App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Navigate to HomeScreen
    );
  }
}
