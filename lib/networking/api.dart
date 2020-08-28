import 'package:http/http.dart' as http;
import 'package:movie_app/models/enums/search_type_enum.dart';
import 'package:movie_app/networking/keys.dart';
import 'dart:convert';

class Api {
  String baseUrl = "https://api.themoviedb.org/3";
  String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  Future search({String query, SearchType searchType}) async {
    String searchUrl;
    if (searchType == SearchType.movie) {
      searchUrl = "$baseUrl/search/movie?api_key=$apiKey&query=$query";
    } else {
      searchUrl = "$baseUrl/search/tv?api_key=$apiKey&query=$query";
    }
    http.Response searchResponse = await http.get(searchUrl);
    var jsonData = jsonDecode(searchResponse.body);
    var results;
    if (searchResponse.statusCode == 200) {
      results = {
        "status": "success",
        "results": jsonData["results"],
      };
    } else {
      results = jsonData["status_message"];
    }
    return results;
  }

  Future getTrending({String timeWindow, String mediaType}) async {
    String getUrl = "$baseUrl/trending/$mediaType/$timeWindow?api_key=$apiKey";
    http.Response trendingResponse = await http.get(getUrl);
    var jsonData = jsonDecode(trendingResponse.body);
    var results;
    if (trendingResponse.statusCode == 200) {
      results = {
        "status": "success",
        "results": jsonData["results"],
      };
    } else {
      results = {
        "status": "fail",
        "status_message": jsonData["status_message"],
      };
    }
    return results;
  }

  discover() async {
    String getUrl =
        "$baseUrl/discover/movie?api_key=$apiKey&language=en-US&sort_by=popularity.desc";
    http.Response discoverResponse = await http.get(getUrl);
    var jsonData = jsonDecode(discoverResponse.body);
    dynamic discoverResults;
    if (discoverResponse.statusCode == 200) {
      discoverResults = {
        "status": "success",
        "results": jsonData["results"],
      };
    } else {
      discoverResults = {
        "status": "fail",
        "status_message": jsonData["status_message"],
      };
    }
    return discoverResults;
  }

  getMovieDetails(String movieId) async {
    String getUrl = "$baseUrl/movie/$movieId?api_key=$apiKey";
    http.Response getResponse = await http.get(getUrl);
    var jsonData = jsonDecode(getResponse.body);
    var movieDetails;
    if (getResponse.statusCode == 200) {
      movieDetails = {"status": "success", "results": jsonData};
    } else {
      movieDetails = {
        "status": "fail",
        "status_message": jsonData["status_message"],
      };
    }
    return movieDetails;
  }

  getTvShowDetails(String showId) async {
    String getUrl = "$baseUrl/tv/$showId?api_key=$apiKey";
    http.Response tvShowResponse = await http.get(getUrl);
    var jsonData = jsonDecode(tvShowResponse.body);
    var tvShowDetails;
    if (tvShowResponse.statusCode == 200) {
      tvShowDetails = {
        "status": "success",
        "results": jsonData,
      };
    } else {
      tvShowDetails = jsonData["status_message"];
    }
    return tvShowDetails;
  }

  getMovieRecommendations(String movieId) async {
    String getUrl = "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";
    http.Response recommendationResponse = await http.get(getUrl);
    var jsonData = jsonDecode(recommendationResponse.body);
    var recommendations;
    if (recommendationResponse.statusCode == 200) {
      recommendations = {
        "status": "success",
        "results": jsonData["results"],
      };
    } else {
      recommendations = {
        "status": "fail",
        "results": jsonData["status_message"],
      };
    }
    return recommendations;
  }
}
