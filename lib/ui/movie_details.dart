import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class MovieDetail extends StatelessWidget {
  final Movie movie;
  MovieDetail({this.movie});
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.backgroundBlack,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              height: screenSize.height * 0.567,
              width: double.infinity,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.5, 0.95, 1],
                  colors: [
                    Style.defaultWhite.withOpacity(0),
                    Color(0xFF62626).withOpacity(0),
                    Style.backgroundBlack,
                  ],
                ),
              ),
              decoration: BoxDecoration(),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Text(
                movie?.movieName ?? "Movie Name",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: Text(
                "August 24,2020",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
                top: 8,
              ),
              child: Text(
                movie?.tagLine ?? "An entire universe ,once and for all",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Text(
                "Overview",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.defaultWhite,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
                right: 16,
              ),
              child: Text(
                movie?.overview ?? "Actual Overview",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                bottom: 8,
              ),
              child: Text(
                "Recommendations",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.defaultWhite,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
