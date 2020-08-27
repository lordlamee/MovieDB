import 'package:flutter/material.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/ui/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageIndicatorProvider>(
      create: (context) => PageIndicatorProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
