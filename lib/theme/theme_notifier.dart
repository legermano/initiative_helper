import 'package:flutter/material.dart';
import 'package:initiative_helper/theme/custom_themes.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData themeData = lightTheme;

  ThemeNotifier({this.themeData});

  getTheme() => themeData;

  setTheme(ThemeData themeData) async {
    themeData = themeData;
    notifyListeners();
  }
}