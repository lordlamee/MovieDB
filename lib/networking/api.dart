import 'package:http/http.dart' as http;
import 'package:movie_app/components/models/enums/search_type_enum.dart';
import 'package:movie_app/networking/keys.dart';
import 'dart:convert';

class Api {
  String baseUrl = "https://api.themoviedb.org/3";
  String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  Future<dynamic> searchMovie({String query, SearchType searchType}) async {
    String searchUrl;
    if (searchType == SearchType.movie) {
      searchUrl = "$baseUrl/search/movie?api_key=$apiKey&query=$query";
    } else {
      searchUrl = "$baseUrl/search/tv?api_key=$apiKey&query=$query";
    }
    http.Response searchResponse = await http.get(searchUrl);
    var jsonData = jsonDecode(searchResponse.body);
    List<Map<String, dynamic>> results;
    if (searchResponse.statusCode == 200) {
      results = jsonData["results"];
    } else {
      results = jsonData["status_message"];
    }
    return results;
  }

  Future<dynamic> getTrending({String timeWindow, String mediaType}) async {
    String getUrl = "$baseUrl/trending/$mediaType/$timeWindow?api_key=$apiKey";
    http.Response trendingResponse = await http.get(getUrl);
    var jsonData = jsonDecode(trendingResponse.body);
    List<Map<String, dynamic>> results;
    if (trendingResponse.statusCode == 200) {
      results = jsonData["results"];
    } else {
      results = jsonData["status_message"];
    }
    return results;
  }
}
