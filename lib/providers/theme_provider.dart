import 'package:flutter/material.dart';
import 'package:tres_astronautras/shared_preferences/preferences.dart';

class ThemeProvider extends ChangeNotifier {

  ThemeData currentTheme;

  ThemeProvider({
    required bool isDarkmode,
  }): currentTheme = isDarkmode ? ThemeData.dark() : ThemeData.light();


  bool _isDark = Preferences.isDarkmode;
  bool get isDark => _isDark;

  setLightmode() {
    _isDark = false;
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  setDarkmode() {
    _isDark = true;
    currentTheme = ThemeData.dark();
    notifyListeners();
  }

}