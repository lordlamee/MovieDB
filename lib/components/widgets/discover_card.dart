import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/controllers/movie_detail_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/indicator/indicators.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key key,
    this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      child: Container(
        height: screenSize.height * 0.338,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16,
          bottom: 16,
        ),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          image: DecorationImage(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w500${movie?.imageUrl}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            movie?.movieName ?? "",
            style: Style.defaultTextStyle.copyWith(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
