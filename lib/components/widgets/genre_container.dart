import 'package:flutter/material.dart';

class GenreContainer extends StatelessWidget {
  GenreContainer({this.genre});
  final String genre;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Theme.of(context).textTheme.bodyText1.color,
          width: 1,
        ),
      ),
      child: Text(
        genre ?? "",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
