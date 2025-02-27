import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:shared_preferences/shared_preferences.dart";

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isDarkMode = false;
  bool _expenseLoggingNotif = false;
  bool _budgetAlerts = false;
  bool _savingsReminders = false;
  bool _offlineMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  // Load settings from shared preferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _expenseLoggingNotif = prefs.getBool('expenseLoggingNotif') ?? false;
      _budgetAlerts = prefs.getBool('budgetAlerts') ?? false;
      _savingsReminders = prefs.getBool('savingsReminders') ?? false;
      _offlineMode = prefs.getBool('offlineMode') ?? false;
    });
  }

  // Save settings to shared preferences
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
    prefs.setBool('expenseLoggingNotif', _expenseLoggingNotif);
    prefs.setBool('budgetAlerts', _budgetAlerts);
    prefs.setBool('savingsReminders', _savingsReminders);
    prefs.setBool('offlineMode', _offlineMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: Text('Expense Logging Notifications'),
            value: _expenseLoggingNotif,
            onChanged: (bool value) {
              setState(() {
                _expenseLoggingNotif = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: Text('Budget Alerts'),
            value: _budgetAlerts,
            onChanged: (bool value) {
              setState(() {
                _budgetAlerts = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: Text('Savings Goal Reminders'),
            value: _savingsReminders,
            onChanged: (bool value) {
              setState(() {
                _savingsReminders = value;
              });
              _saveSettings();
            },
          ),
          SwitchListTile(
            title: Text('Offline Mode'),
            value: _offlineMode,
            onChanged: (bool value) {
              setState(() {
                _offlineMode = value;
              });
              _saveSettings();
            },
          ),
        ],
      ),
    );
  }
}
