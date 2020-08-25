class Movie {
  String movieName;
  double rating;
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

  Movie.fromJson(Map<String,dynamic> jsonData){
    movieName = jsonData["title"];
    movieId = jsonData["id"];
    overview = jsonData["overview"];
    imageUrl = jsonData["poster_path"];
    releaseDate = jsonData["release_date"];
    rating = jsonData["vote_average"];
  }
}
