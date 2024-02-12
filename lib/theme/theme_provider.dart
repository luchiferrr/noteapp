import 'package:flutter/material.dart';
import 'package:noteapp/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  // initially, theme is a light mode
  ThemeData _themeData = lightMode;

  //getter method to access the theme of the other parts of the code
ThemeData get themeData => _themeData;

// getter method to see if we are in a dark mode or not
bool get isDarkMode => _themeData == darkMode;

//setter method to set the new theme
set themeData(ThemeData themeData) {
  _themeData = themeData;
  notifyListeners();
}
  //toggle to a switch mode
void toggleTheme() {
  if (_themeData == lightMode) {
    themeData = darkMode;

  } else {
    themeData = lightMode;
  }
}
}