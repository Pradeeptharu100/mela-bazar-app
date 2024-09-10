import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveProvider extends ChangeNotifier {
  static const String _themeModeKey = 'themeMode';

  late ThemeMode _themeMode;
  late Box<dynamic> settingsBox;

  HiveProvider() {
    settingsBox = Hive.box('settings');
    _themeMode = _getThemeModeFromBox();
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  Future<void> saveThemeMode(ThemeMode mode) async {
    final themeString = mode == ThemeMode.dark ? 'dark' : 'light';
    await settingsBox.put(_themeModeKey, themeString);
    _themeMode = mode;
    _getThemeModeFromBox();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await saveThemeMode(mode);
  }

  void toggleThemeMode() {
    final newMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setThemeMode(newMode);
    notifyListeners();
  }

  ThemeMode _getThemeModeFromBox() {
    final String? storedThemeMode = settingsBox.get(_themeModeKey);
    if (storedThemeMode == 'dark') {
      return ThemeMode.dark;
    } else if (storedThemeMode == 'light') {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
