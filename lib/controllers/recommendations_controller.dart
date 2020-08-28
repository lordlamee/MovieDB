import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api.dart';

class RecommendationController {
  Api api = Api();
  getRecommendations(String movieId) async {
    var recommendedMoviesResponse = await api.getMovieRecommendations(movieId);
    if (recommendedMoviesResponse["status"] == "success") {
      List<dynamic> recommendedMoviesList =
          recommendedMoviesResponse["results"];
      List<Movie> movies = [];
      for (Map<String, dynamic> movieData in recommendedMoviesList) {
        Movie movie = Movie.fromJson(movieData);
        movies.add(movie);
      }
      return {
        "status": "success",
        "items": movies,
      };
    } else {
      return {
        "status": "fail",
        "status_message": recommendedMoviesResponse["status_message"],
      };
    }
  }
}
