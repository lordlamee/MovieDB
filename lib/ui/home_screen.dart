import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/build_functions.dart';
import 'package:movie_app/components/widgets/discover_card.dart';
import 'package:movie_app/components/widgets/movie_card.dart';
import 'package:movie_app/controllers/discover_controller.dart';
import 'package:movie_app/controllers/trending_controller.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/provider/theme_provide.dart';
import 'package:movie_app/theme/theme_config.dart';
import 'package:movie_app/ui/search_delegate.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _discoverController = PageController();
  List<Movie> discoverMovies = [];
  List<Movie> trendingMoviesDaily = [];
  List<Movie> trendingMoviesWeekly = [];
  bool loading = true;
  @override
  void initState() {
    super.initState();
    Future(() async {
      final discover = await DiscoverController().handleDiscoverItems();
      discoverMovies = discover["items"];
      final trendingDaily = await TrendingController().trendingMoviesDaily();
      trendingMoviesDaily = trendingDaily["items"];
      final trendingWeekly = await TrendingController().trendingMoviesWeekly();
      trendingMoviesWeekly = trendingWeekly["items"];
      setState(() {
        loading = false;
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
          if (trendingMoviesWeekly.isNotEmpty)
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).switchTheme();
          },
          icon: Icon(Icons.format_paint),
        ),
        actions: [
          buildSearchIcon(context, MoviesSearchDelegate()),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Text(
                        "Discover",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      height: 250,
                      child: PageView(
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
                        style: TextStyle(
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
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: trendingMoviesDaily.length,
                        itemBuilder: (context, index) {
                          if (trendingMoviesDaily.isNotEmpty) {
                            return MovieCard(
                              movie: trendingMoviesDaily[index],
                            );
                          } else {
                            return Center(
                              child: Text(
                                "No data found",
                                style: TextStyle(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RowHeading(
                      title: "This week",
                    ),
                    Container(
                      height: 250,
                      child: ListView.separated(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: trendingMoviesWeekly.length,
                        itemBuilder: (context, index) {
                          if (trendingMoviesWeekly.isNotEmpty) {
                            return MovieCard(
                              movie: trendingMoviesWeekly[index],
                            );
                          } else {
                            return Center(
                              child: Text(
                                "No data found",
                                style: TextStyle(),
                              ),
                            );
                          }
                        },
                      ),
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
        color: selected
            ? ThemeConfig.themeGrey
            : Theme.of(context).textTheme.headline6.color,
      ),
    );
  }
}
