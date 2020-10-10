import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/networking/api.dart';

class DiscoverController {
  Future<Map<String, dynamic>> handleDiscoverItems() async {
    Api api = Api();
    var discoverResults = await api.discover();
    if (discoverResults["status"] == "success") {
      List<dynamic> discoverMovies = discoverResults["results"];
      List<Movie> discover = [];
      for (int i = 0; i < 10; i++) {
        Movie movie = Movie.fromJson(discoverMovies[i]);
        discover.add(movie);
      }

      return {
        "status": "success",
        "items": discover,
      };
    } else {
      print("fail");
      return {
        "status": "fail",
        "status_message": discoverResults["status_message"]
      };
    }
  }
}
