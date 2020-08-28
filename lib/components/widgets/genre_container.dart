import 'package:flutter/material.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

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
          width: 1,
          color: Style.themeWhite,
        ),
      ),
      child: Text(
        genre ?? "",
        style: Style.defaultTextStyle.copyWith(
          color: Style.themeWhite.withOpacity(0.8),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
