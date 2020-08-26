import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class MovieCard extends StatelessWidget {
  const MovieCard({Key key, this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 118,
      margin: EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 118,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500${movie.imageUrl}"),
                fit: BoxFit.fill,
              ),
              color: Style.themeWhite,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "${movie?.movieName ?? "movie name"}",
              style: Style.defaultTextStyle.copyWith(
                fontSize: 14,
                color: Style.themeWhite,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "${movie?.releaseDate?.substring(0, 4) ?? ""}",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
              Spacer(),
              Text(
                "${movie?.rating ?? ""}",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite,
                  fontSize: 12,
                ),
              ),
              Icon(
                Icons.star,
                color: Style.appYellow,
              ),
            ],
          ),
        ],
      ),
    );
  }
}