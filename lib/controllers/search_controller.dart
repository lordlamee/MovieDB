import 'package:movie_app/models/enums/search_type_enum.dart';
import 'package:movie_app/networking/api.dart';
import 'package:movie_app/models/movie_model.dart';

class SearchController {
  Api api = Api();
  handleSearch(String query, SearchType searchType) async {
    var searchResults = await api.search(query: query, searchType: searchType);
    if (searchResults["status"] == "success") {
      if (searchType == SearchType.movie) {
        List<dynamic> movieList = searchResults["results"];
        List<Movie> movies = [];
        for (dynamic movieData in movieList) {
          Movie movie = Movie.fromJson(movieData);
          movies.add(movie);
        }
        return {"status": "success", "results": movies};
      } else {
        //:Todo Implement TV shows search results
        return null;
      }
    } else {
      return {"status_message": searchResults};
    }
  }

  getSearchResults(query, List<Movie> movies) async {
    var searchResponse = await handleSearch(query, SearchType.movie);
    if (searchResponse["status"] == "success") {
      movies = searchResponse["results"];
    }
  }
}
