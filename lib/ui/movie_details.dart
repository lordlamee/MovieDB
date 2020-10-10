import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_app/components/widgets/build_functions.dart';
import 'package:movie_app/components/widgets/genre_container.dart';
import 'package:movie_app/components/widgets/movie_card.dart';
import 'package:movie_app/components/widgets/star_rating.dart';
import 'package:movie_app/components/widgets/video_tile.dart';
import 'package:movie_app/controllers/movie_detail_controller.dart';
import 'package:movie_app/controllers/recommendations_controller.dart';
import 'package:movie_app/controllers/video/video_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/utilities/constants.dart';

class MovieDetail extends StatefulWidget {
  final String movieId;
  MovieDetail({this.movieId});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail>
    with SingleTickerProviderStateMixin {
  Future movieDetails;
  Future recommendedMovies;
  List<Video> videos = [];
  TabController tabBarController;
  Future videoSnapshot;
  getTrailers() async {
    var videoResponse = await VideoController().videos(widget.movieId);
    setState(() {
      videos = videoResponse["items"];
    });
  }

  @override
  void initState() {
    videoSnapshot = VideoController().videos(widget.movieId);
    movieDetails = MovieDetailController().getMovieDetails(widget.movieId);
    recommendedMovies =
        RecommendationController().getRecommendations(widget.movieId);
    getTrailers();
    tabBarController = TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: FutureBuilder<Movie>(
            future: movieDetails,
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
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints.tight(screenSize),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              bottom: 8,
                              top: 12,
                            ),
                            child: Text(
                              snapshot.data?.movieName ?? "Movie Title",
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
                            child: Row(
                              children: [
                                StarRating(
                                  rating:
                                      double.parse(snapshot.data.rating) / 2,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  formatDateToYear(snapshot.data.releaseDate),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
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
                              snapshot.data?.tagLine ?? "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TabBar(controller: tabBarController, tabs: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                "Overview",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Text(
                                "Trailers",
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 16),
                              child: TabBarView(
                                  controller: tabBarController,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        bottom: 16,
                                        right: 16,
                                      ),
                                      child: Text(
                                        snapshot.data?.overview ??
                                            "Actual Overview",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    FutureBuilder(
                                        future: videoSnapshot,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot
                                                .data["items"].isNotEmpty) {
                                              return Scrollbar(
                                                child: ListView.separated(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16,
                                                            vertical: 8),
                                                    separatorBuilder:
                                                        (context, index) =>
                                                            SizedBox(
                                                              height: 16,
                                                            ),
                                                    itemCount: snapshot
                                                        .data["items"].length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return VideoTile(
                                                        video: snapshot
                                                                .data["items"]
                                                            [index],
                                                      );
                                                    }),
                                              );
                                            } else {
                                              return Center(
                                                child: Text("No Media Here"),
                                              );
                                            }
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        }),
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
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
                            height: 220,
                            child: FutureBuilder(
                              future: recommendedMovies,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (!snapshot.hasError) {
                                    if (snapshot.data["items"].isNotEmpty) {
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
                                          itemCount:
                                              snapshot.data["items"].length,
                                          itemBuilder: (context, index) {
                                            return MovieCard(
                                              movie: snapshot.data["items"]
                                                  [index],
                                            );
                                          });
                                    } else {
                                      return Container(
                                        child: Center(
                                          child: Text(
                                            "Nothing here...",
                                            style: TextStyle(),
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    return Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Unknown error",
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
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
