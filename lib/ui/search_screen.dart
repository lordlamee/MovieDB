import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/movie_tile.dart';
import 'package:movie_app/controllers/search_controller.dart';
import 'package:movie_app/models/enums/search_type_enum.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loading = false;
  List<Movie> searchMovies = [];
  getMoviesList() {
    if (searchMovies.isNotEmpty) {
      List<MovieTile> movies = [];
      for (Movie movie in searchMovies) {
        MovieTile movieTile = MovieTile(
          movie: movie,
        );
        movies.add(movieTile);
      }
      return movies;
    } else {
      return Container(
        child: Center(
          child: Text(
            "No Result",
            style: Style.defaultTextStyle,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundBlack,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                ShowTypeButton(),
//                ShowTypeButton(),
//              ],
//            ),
            TextFormField(
              onChanged: (query) async {
                setState(() {
                  loading = true;
                });
                var searchResponse = await SearchController()
                    .handleSearch(query, SearchType.movie);
                if (searchResponse["status"] == "success") {
                  searchMovies = searchResponse["results"];
                }
                setState(() {
                  loading = false;
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Style.defaultWhite,
                ),
                filled: true,
                hintText: "Search for your favorite movies",
                hintStyle: Style.defaultTextStyle.copyWith(
                  color: Style.defaultWhite.withOpacity(0.6),
                  fontSize: 15,
                ),
                fillColor: Color(0xFF8E8D8D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            loading
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: ListView(
                        children: searchMovies.isNotEmpty
                            ? getMoviesList()
                            : [getMoviesList()]),
                  ),
//            Expanded(
//              child: Container(),
//            ),
          ],
        ),
      ),
    );
  }
}

class ShowTypeButton extends StatelessWidget {
  const ShowTypeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 32),
      color: Style.themeWhite,
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        "Movies",
        style: Style.defaultTextStyle.copyWith(
          color: Style.backgroundBlack,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
