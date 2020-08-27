import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/discover_card.dart';
import 'package:movie_app/components/widgets/movie_card.dart';
import 'package:movie_app/controllers/discover_controller.dart';
import 'package:movie_app/controllers/trending_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:movie_app/utilities/styles.dart' as Style;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _discoverController = PageController();
  List<Movie> discoverMovies = [];
  String errorMessage;
  bool loadingDiscover = true;
  List<MovieCard> trendingToday = [];
  List<MovieCard> trendingThisWeek = [];
  @override
  void initState() {
    super.initState();
    Future(() async {
      final discover = await DiscoverController().handleDiscoverItems();
      discoverMovies = discover["items"];
      setState(() {
        loadingDiscover = false;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(Duration(seconds: 4), (timer) {
        if (discoverMovies.isNotEmpty) {
          if (Provider.of<PageIndicatorProvider>(context, listen: false)
                  .selectedDiscoverPage <
              2) {
            Provider.of<PageIndicatorProvider>(context, listen: false)
                .increaseIndex();
          } else {
            Provider.of<PageIndicatorProvider>(context, listen: false)
                .setIndex(0);
          }
          assert(discoverMovies.isNotEmpty);
          _discoverController.animateToPage(
            Provider.of<PageIndicatorProvider>(context, listen: false)
                .selectedDiscoverPage,
            duration: Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _discoverController.dispose();
    super.dispose();
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
                child:
//                FutureBuilder(
//                    future: DiscoverController().handleDiscoverItems(),
//                    builder: (context, snapshot) {
//                      if (snapshot.connectionState == ConnectionState.done) {
//                        if (!snapshot.hasError) {
//                          return
                    loadingDiscover
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : PageView(
                            controller: _discoverController,
                            onPageChanged: (index) {
                              Provider.of<PageIndicatorProvider>(context,
                                      listen: false)
                                  .pageIndicator(index);
                            },
                            children: [
                              for (int i = 0; i < 3; i++)
                                DiscoverCard(
                                  movie: discoverMovies[i],
                                ),
                            ],
                          ),
//    ;
//                        } else {
//                          return Container(
//                            child: Center(
//                              child: Text(
//                                snapshot.error.toString(),
//                                style: Style.defaultTextStyle,
//                              ),
//                            ),
//                          );
//                        }
//                      } else {
//                        return Center(child: CircularProgressIndicator());
//                      }
//                    }),
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
