import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api.dart';

class TrendingController {
  Api api = Api();
  trendingMoviesDaily() async {
    var trendingMoviesByDay =
        await api.getTrending(mediaType: "movie", timeWindow: "day");
    if (trendingMoviesByDay["status"] == "success") {
      List<dynamic> movieList = trendingMoviesByDay["results"];
      List<Movie> movies = [];
      for (Map<String, dynamic> movie in movieList) {
        Movie trending = Movie.fromJson(movie);
        movies.add(trending);
      }
      return {
        "status": "success",
        "items": movies,
      };
    } else {
      return {
        "status": "fail",
        "status_message": trendingMoviesByDay["status_message"]
      };
    }
  }

  trendingMoviesWeekly() async {
    var trendingMoviesByWeek =
        await api.getTrending(mediaType: "movie", timeWindow: "week");
    if (trendingMoviesByWeek["status"] == "success") {
      List<dynamic> movieList = trendingMoviesByWeek["results"];
      List<Movie> movies = [];
      for (Map<String, dynamic> movie in movieList) {
        Movie trending = Movie.fromJson(movie);
        movies.add(trending);
      }
      return {
        "status": "success",
        "items": movies,
      };
    } else {
      return {
        "status": "fail",
        "status_message": trendingMoviesByWeek["status_message"]
      };
    }
  }
}
