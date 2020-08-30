import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/build_functions.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/ui/movie_details.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/styles.dart' as Style;

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key key,
    this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: InkWell(
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: FadeInImage.assetNetwork(
                width: 110,
                height: 150,
                placeholder: "assets/placeholder.png",
                image: "$movieBaseUrl${movie.imageUrl}",
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Style.defaultWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            movie.movieName ?? "",
                            style: Style.defaultTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Style.backgroundBlack,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${movie?.rating ?? ""}",
                              style: Style.defaultTextStyle.copyWith(
                                color: Style.backgroundBlack,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Style.appYellow,
                              size: 19,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      formatDate(movie?.releaseDate ?? ""),
                      style: Style.defaultTextStyle.copyWith(
                        fontSize: 15,
                        color: Style.textGrey,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        movie.overview.length > 60
                            ? "${movie.overview.substring(0, 60) ?? ""}" + "..."
                            : movie.overview,
                        style: Style.defaultTextStyle.copyWith(
                          fontSize: 18,
                          color: Style.backgroundBlack.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
