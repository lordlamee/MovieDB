import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool darkTheme = true;
  void switchTheme() {
    darkTheme = !darkTheme;
    notifyListeners();
  }
}
