import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/build_functions.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details.dart';
import 'package:movie_app/utilities/constants.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({Key key, this.movie}) : super(key: key);
  final Movie movie;

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => MovieDetail(
              movieId: widget.movie.movieId,
            ),
          ),
        );
      },
      child: Container(
        width: 118,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                width: 118,
                height: 150,
                placeholder: "assets/placeholder.png",
                image: "$movieBaseUrl${widget.movie.imageUrl}",
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${widget.movie?.movieName ?? "movie name"}",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "${formatDateToYear(widget.movie.releaseDate) ?? ""}",
                  style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .caption
                        .color
                        .withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                Text(
                  "${widget.movie?.rating ?? ""}",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
