import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/genre_container.dart';
import 'package:movie_app/components/widgets/movie_card.dart';
import 'package:movie_app/controllers/recommendations_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class MovieDetail extends StatelessWidget {
  final Movie movie;
  MovieDetail({this.movie});
  getRecommendedMovies(List<Movie> movies) {
    List<MovieCard> recommendedMovies = [];
    if (movies.isNotEmpty) {
      if (movies.length > 10) {
        for (int i = 0; i < 10; i++) {
          MovieCard newMovie = MovieCard(
            movie: movies[i],
          );
          recommendedMovies.add(newMovie);
        }
        return recommendedMovies;
      } else {
        for (Movie movie in movies) {
          MovieCard newMovie = MovieCard(
            movie: movie,
          );
          recommendedMovies.add(newMovie);
        }
        return recommendedMovies;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int releaseMonth = int.parse(movie.releaseDate.substring(5, 7));
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${movie.imageUrl}"),
                  fit: BoxFit.fill,
                ),
              ),
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
                "${months[releaseMonth]}" +
                    " ${movie.releaseDate.substring(8, 10)}," +
                    "${movie.releaseDate.substring(0, 4)}",
                style: Style.defaultTextStyle.copyWith(
                  color: Style.themeWhite,
                  fontSize: 15,
                ),
              ),
            ),
            Wrap(
              children: [
                for (dynamic genre in movie.genres)
                  GenreContainer(
                    genre: genre["name"],
                  ),
              ],
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
            Container(
              height: 250,
              child: FutureBuilder(
                future: RecommendationController()
                    .getRecommendations(movie.movieId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasError) {
                      if (snapshot.hasData) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          children:
                              getRecommendedMovies(snapshot.data["items"]),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: Text(
                              snapshot.error.toString(),
                            ),
                          ),
                        );
                      }
                    } else {
                      return Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          snapshot.data["status_message"],
                          style: Style.defaultTextStyle,
                        ),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
