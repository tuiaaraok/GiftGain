import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeProvider with ChangeNotifier {
  final String _boxName = 'themePrefs';
  final String _key = 'isDarkMode';

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_boxName);
    _isDarkMode = box.get(_key, defaultValue: false);
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    final box = await Hive.openBox(_boxName);
    _isDarkMode = value;
    await box.put(_key, _isDarkMode);
    notifyListeners();
  }
}
