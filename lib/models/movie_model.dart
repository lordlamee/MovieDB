class Movie {
  String movieName;
  String rating;
  String imageUrl;
  String releaseDate;
  String movieId;
  String overview;
  Movie({
    this.movieName,
    this.movieId,
    this.overview,
    this.imageUrl,
    this.rating,
    this.releaseDate,
  });

  Movie.fromJson(Map<String, dynamic> jsonData) {
    movieName = jsonData["title"].toString();
    movieId = jsonData["id"].toString();
    overview = jsonData["overview"].toString();
    imageUrl = jsonData["poster_path"].toString();
    releaseDate = jsonData["release_date"].toString();
    rating = jsonData["vote_average"].toString();
  }
}