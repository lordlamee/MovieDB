import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class DiscoverCard extends StatelessWidget {
  const DiscoverCard({
    Key key,
    this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MovieDetail(
              movieId: movie.movieId,
            ),
          ),
        );
      },
      child: Container(
        height: screenSize.height * 0.338,
        width: double.infinity,
        padding: EdgeInsets.only(
          left: 16,
          bottom: 16,
        ),
        margin: EdgeInsets.fromLTRB(16, 0, 16, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w500${movie?.imageUrl}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Color(0xFFFCFDFE).withOpacity(0.6),
            padding: EdgeInsets.all(4),
            child: Text(
              movie?.movieName ?? "",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
