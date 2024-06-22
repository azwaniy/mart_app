import 'package:flutter/material.dart';
import 'package:mart_app/themes/dark_mode.dart';
import 'package:mart_app/themes/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData == darkMode;
    } else {
      themeData == lightMode;
    }
  }
}