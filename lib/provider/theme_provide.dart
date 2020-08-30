import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkTheme = false;
  void switchTheme() {
    darkTheme = !darkTheme;
    notifyListeners();
  }
}
