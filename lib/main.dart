import 'package:flutter/material.dart';
import 'package:movie_app/ui/home_screen.dart';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Home(),
    );
  }
}