import 'package:flutter/material.dart';

/*
* Created by Jackson Stephen, jacksonsteven436@gmail.com: 08|01|2025
* */

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDark => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
