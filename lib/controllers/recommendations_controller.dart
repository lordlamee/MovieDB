import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api.dart';

class RecomendationController {
  Api api = Api();
  getRecommendations(String movieId) async {
    var recommendedMoviesResponse = await api.getMovieRecommendations(movieId);
    if (recommendedMoviesResponse["status"] == "success") {
      List<Map<String, dynamic>> recommendedMoviesList =
          recommendedMoviesResponse["results"];
      List<Movie> movies = [];
      for (Map<String, dynamic> movieData in recommendedMoviesList) {
        Movie movie = Movie.fromJson(movieData);
        movies.add(movie);
      }
      return movies;
    } else {
      return recommendedMoviesResponse["status_message"];
    }
  }
}
