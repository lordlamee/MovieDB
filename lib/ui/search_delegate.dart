import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/movie_tile.dart';
import 'package:movie_app/controllers/search_controller.dart';
import 'package:movie_app/models/enums/search_type_enum.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class MoviesSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      InkWell(
          onTap: () {
            query = "";
          },
          child: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != "" && query != null) {
      return FutureBuilder(
        future: SearchController().handleSearch(query, SearchType.movie),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data["status"] == "success") {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return MovieTile(
                      movie: snapshot.data["results"][index],
                    );
                  },
                  itemCount: snapshot.data["results"].length,
                );
              } else {
                return Center(
                  child: Text(
                    "",
                    style: Style.defaultTextStyle,
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  'No Movies Found',
                  style: Style.defaultTextStyle,
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return Center(
        child: Text(
          "Enter keyword to start searching",
          style: Style.defaultTextStyle.copyWith(
            color: Style.themeWhite,
          ),
        ),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != "" && query != null) {
      return FutureBuilder(
        future: SearchController().handleSearch(query, SearchType.movie),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.data["status"] == "success") {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return MovieTile(
                      movie: snapshot.data["results"][index],
                    );
                  },
                  itemCount: snapshot.data["results"].length,
                );
              } else {
                return Center(
                  child: Text(
                    "",
                    style: Style.defaultTextStyle,
                  ),
                );
              }
            } else {
              return Center(
                child: Text(
                  'No Movies Found',
                  style: Style.defaultTextStyle,
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    } else {
      return Center(
        child: Text(
          "Enter keyword to start searching",
          style: Style.defaultTextStyle.copyWith(
            color: Style.themeWhite,
          ),
        ),
      );
    }
  }
}
