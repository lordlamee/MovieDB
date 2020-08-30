import 'package:flutter/material.dart';

class ThemeConfig {
  //Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Color(0xff1f1f1f);
  static Color lightAccent = Color(0xFFFFCE31);
  static Color darkAccent = Color(0xFFFFCE31);
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Color(0xff121212);

  static Color backgroundBlack = Color(0xFF161616);
  static Color defaultWhite = Color(0xFFFFFFFF);
  static Color themeWhite = Color(0xFFFCFCFC);
  static Color textBlack = Color(0xFF1F1F1F);
  static Color appYellow = Color(0xFFFFCE31);
  static Color textGrey = Color(0xFF696969);
  static Color themeGrey = Color(0xFF8E8D8D);


  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0.0,
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static Color profileCardShadowColor = Colors.grey[200];
}
