import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/build_functions.dart';
import 'package:movie_app/components/widgets/star_rating.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details.dart';
import 'package:movie_app/utilities/constants.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key key, this.movie, this.width = 140, this.height = 148})
      : super(key: key);
  final Movie movie;
  final double width;
  final double height;

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
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: width,
              height: height,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage.assetNetwork(
                      width: width,
                      height: height,
                      placeholder: "assets/placeholder.png",
                      image: "$movieBaseUrl${movie.imageUrl}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    color: Color(0xFFFCFDFE).withOpacity(0.6),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "${formatDateToYear(movie.releaseDate) ?? ""}",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 6,
                        right: 8,
                      ),
                      child: StarRating(
                        iconSize: 14,
                        rating: double.parse(movie.rating) / 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${movie?.movieName ?? "movie name"}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
