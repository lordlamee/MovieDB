import 'package:flutter/material.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'utilities/styles.dart' as Style;

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageIndicatorProvider>(
      create: (context) => PageIndicatorProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Style.backgroundBlack,
          canvasColor: Style.backgroundBlack,
          cursorColor: Style.themeWhite,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
