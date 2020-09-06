import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/provider/theme_provide.dart';
import 'package:movie_app/theme/theme_config.dart';
import 'package:movie_app/ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'utilities/styles.dart' as Style;

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageIndicatorProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MovieDb(),
    );
  }
}

class MovieDb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme
          ? themeData(ThemeConfig.darkTheme)
          : themeData(ThemeConfig.lightTheme),
      home: Home(),
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(
        theme.textTheme,
      ),
    );
  }
}
