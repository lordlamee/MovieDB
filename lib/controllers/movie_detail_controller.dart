import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api.dart';

class MovieDetailController {
  Api api = Api();
  getMovieDetails(String movieId) async {
    dynamic movieDetails = await api.getMovieDetails(movieId);
    Movie movie;
    if (movieDetails["status"] == "success") {
      movie = Movie.fromJson(movieDetails["results"]);
    } else {
      movie = Movie(movieName: movieDetails["status_message"]);
    }
    return movie;
  }
}
