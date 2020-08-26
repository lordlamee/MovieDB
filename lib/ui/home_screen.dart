import 'package:flutter/material.dart';
import 'package:movie_app/controllers/discover_controller.dart';
import 'package:movie_app/controllers/trending_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/styles.dart' as Style;
import 'package:movie_app/utilities/widgets/discover_card.dart';
import 'package:movie_app/utilities/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _discoverController = PageController();
  List<DiscoverCard> discoverMovies = [];
  String errorMessage;
  List<MovieCard> trendingToday = [];
  List<MovieCard> trendingThisWeek = [];
  @override
  void initState() {
    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      Timer.periodic(Duration(seconds: 4), (timer) {
//        if (discoverIndex < 2) {
//          discoverIndex++;
//        } else {
//          discoverIndex = 0;
//        }
//        _discoverController.animateToPage(
//          discoverIndex,
//          duration: Duration(milliseconds: 500),
//          curve: Curves.decelerate,
//        );
//      });
    // });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Style.backgroundBlack,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Style.defaultWhite,
                    ),
                    Icon(
                      Icons.search,
                      color: Style.defaultWhite,
                    ),
                  ],
                ),
              ),
              InkResponse(
                onTap: () async {
                  var api = await TrendingController().trendingMoviesDaily();
                  print(api);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    "Discover",
                    style: Style.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Container(
                height: 250,
                child: FutureBuilder(
                    future: DiscoverController().handleDiscoverItems(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasError) {
                          List<DiscoverCard> movieList = [];
                          if (!snapshot.hasData) if (snapshot.data["status"] ==
                              "success") {
                            for (Movie discoverMovie
                                in snapshot.data["items"]) {
                              print(discoverMovie.movieName);
                              print("is it null ni");
                              DiscoverCard discoverCard = DiscoverCard(
                                movie: discoverMovie,
                              );
                              movieList.add(discoverCard);
                            }
                          }
                          return PageView(
                            controller: _discoverController,
                            onPageChanged: (index) {
                              Provider.of<PageIndicatorProvider>(context,
                                      listen: false)
                                  .pageIndicator(index);
                            },
                            children: [
                              for (int i = 0; i < 3; i++)
                                DiscoverCard(
                                  movie: snapshot.data["items"][i],
                                )
                            ],
                          );
                        } else {
                          return Container(
                            child: Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: Style.defaultTextStyle,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              Consumer<PageIndicatorProvider>(
                builder: (context, provider, child) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PageIndicator(
                      selected: provider.selectedDiscoverPage == 0,
                    ),
                    PageIndicator(
                      selected: provider.selectedDiscoverPage == 1,
                    ),
                    PageIndicator(
                      selected: provider.selectedDiscoverPage == 2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  "Trending",
                  style: Style.defaultTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              RowHeading(
                title: "Today",
              ),
              Container(
                height: 220,
                child: FutureBuilder(
                    future: TrendingController().trendingMoviesDaily(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            children: [
                              for (int i = 0; i < 10; i++)
                                MovieCard(
                                  movie: snapshot.data["items"][i],
                                ),
                            ],
                          );
                        } else {
                          return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Empty",
                              style: Style.defaultTextStyle,
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              SizedBox(
                height: 8,
              ),
              RowHeading(
                title: "This week",
              ),
              Container(
                height: 250,
                child: FutureBuilder(
                    future: TrendingController().trendingMoviesWeekly(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.zero,
                            children: [
                              for (int i = 0; i < 10; i++)
                                MovieCard(
                                  movie: snapshot.data["items"][i],
                                ),
                            ],
                          );
                        } else {
                          return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              "Empty",
                              style: Style.defaultTextStyle,
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ]),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key key,
    this.selected = false,
  }) : super(key: key);
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: 3,
      width: 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: selected ? Style.themeGrey : Style.defaultWhite),
    );
  }
}

class RowHeading extends StatelessWidget {
  const RowHeading({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: Style.defaultTextStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
            Text(
              "See all",
              style: Style.defaultTextStyle.copyWith(
                color: Style.defaultWhite.withOpacity(0.8),
                fontSize: 15,
              ),
            ),
          ]),
    );
  }
}
