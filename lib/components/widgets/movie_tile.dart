import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/controllers/movie_detail_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/indicator/indicators.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key key,
    this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: InkWell(
        onTap: () async {
          Indicator.loading(context);
          Movie movieDetail =
              await MovieDetailController().getMovieDetails(movie.movieId);
          Indicator.popIndicator(context);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => MovieDetail(
                movie: movieDetail,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              height: 150,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                image: DecorationImage(
                  image: NetworkImage("$movieBaseUrl${movie.imageUrl}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Style.defaultWhite,
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            movie.movieName ?? "",
                            style: Style.defaultTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Style.backgroundBlack,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${movie?.rating ?? ""}",
                              style: Style.defaultTextStyle.copyWith(
                                color: Style.backgroundBlack,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Style.appYellow,
                              size: 19,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "${months[int.parse(movie.releaseDate.substring(5, 7))]}" +
                          " ${movie.releaseDate.substring(8, 10)}," +
                          "${movie.releaseDate.substring(0, 4)}",
                      style: Style.defaultTextStyle.copyWith(
                        fontSize: 15,
                        color: Style.textGrey,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        movie.overview.length > 60
                            ? "${movie.overview.substring(0, 60) ?? ""}" + "..."
                            : movie.overview,
                        style: Style.defaultTextStyle.copyWith(
                          fontSize: 18,
                          color: Style.backgroundBlack.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
