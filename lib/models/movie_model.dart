class Movie implements Comparable {
  String movieName;
  String rating;
  String imageUrl;
  String releaseDate;
  String movieId;
  String overview;
  String tagLine;
  dynamic genres;
  Movie({
    this.movieName,
    this.movieId,
    this.overview,
    this.imageUrl,
    this.rating,
    this.releaseDate,
    this.tagLine,
    this.genres,
  });

  Movie.fromJson(Map<String, dynamic> jsonData) {
    movieName = jsonData["title"].toString();
    movieId = jsonData["id"].toString();
    overview = jsonData["overview"].toString();
    imageUrl = jsonData["poster_path"].toString();
    releaseDate = jsonData["release_date"].toString();
    rating = jsonData["vote_average"].toString();
    tagLine = jsonData["tagline"].toString();
    genres = jsonData["genres"];
  }

  @override
  int compareTo(otherMovieObject) {
    if (int.parse(this.rating) < int.parse(otherMovieObject.rating)) {
      return 1;
    } else if (int.parse(this.rating) == int.parse(otherMovieObject.rating)) {
      return 0;
    } else if (int.parse(this.rating) > int.parse(otherMovieObject.rating)) {
      return -1;
    } else {
      return null;
    }
  }
}
