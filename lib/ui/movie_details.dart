import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/genre_container.dart';
import 'package:movie_app/components/widgets/movie_card.dart';
import 'package:movie_app/controllers/movie_detail_controller.dart';
import 'package:movie_app/controllers/recommendations_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utilities/constants.dart';

class MovieDetail extends StatelessWidget {
  final String movieId;
  MovieDetail({this.movieId});

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<Movie>(
          future: MovieDetailController().getMovieDetails(movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: screenSize.height * 0.6,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          "https://image.tmdb.org/t/p/w500${snapshot.data.imageUrl}",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 8,
                        ),
                        child: Text(
                          snapshot.data?.movieName ?? "Movie Name",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 16,
                        ),
                        child: Text(
                          "${months[int.parse(snapshot.data.releaseDate.substring(5, 7))]}" +
                              " ${snapshot.data.releaseDate.substring(8, 10)}," +
                              "${snapshot.data.releaseDate.substring(0, 4)}",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Wrap(
                        runSpacing: 8,
                        children: [
                          for (dynamic genre in snapshot.data.genres)
                            GenreContainer(
                              genre: genre["name"],
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 8,
                          top: 8,
                        ),
                        child: Text(
                          snapshot.data?.tagLine ??
                              "An entire universe ,once and for all",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 8,
                        ),
                        child: Text(
                          "Overview",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          bottom: 8,
                          right: 16,
                        ),
                        child: Text(
                          snapshot.data?.overview ?? "Actual Overview",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 16,
                          bottom: 8,
                        ),
                        child: Text(
                          "Recommendations",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 250,
                        child: FutureBuilder(
                          future: RecommendationController()
                              .getRecommendations(snapshot.data.movieId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (!snapshot.hasError) {
                                if (snapshot.hasData) {
                                  return ListView.separated(
                                      padding: EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                      ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            width: 16,
                                          ),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data["items"].length,
                                      itemBuilder: (context, index) {
                                        return MovieCard(
                                          movie: snapshot.data["items"][index],
                                        );
                                      });
                                } else {
                                  return Container(
                                    child: Center(
                                      child: Text(
                                        snapshot.error.toString(),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                return Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data["status_message"],
                                    style: TextStyle(),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
