import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/build_functions.dart';
import 'package:movie_app/components/widgets/discover_card.dart';
import 'package:movie_app/components/widgets/drawer.dart';
import 'package:movie_app/components/widgets/movie_card.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/provider/page_indicator_provider.dart';
import 'package:movie_app/theme/theme_config.dart';
import 'package:movie_app/ui/search_delegate.dart';
import 'package:movie_app/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: MenuButton(),
        actions: [
          buildSearchIcon(
              context,
              MoviesSearchDelegate(
                hintText: "Search...",
              )),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Builder(builder: (context) {
        if (Provider.of<MovieViewModel>(context).trendingMoviesDaily.isEmpty) {
          Provider.of<MovieViewModel>(context, listen: false)
              .getHomeMovies(initialRun: true);
        }

        return Consumer<MovieViewModel>(builder: (context, provider, child) {
          return provider.viewState == ViewState.busy
              ? Center(child: CircularProgressIndicator())
              : provider.getStatus == GetStatus.fail
                  ? InkWell(
                      onTap: () {
                        Provider.of<MovieViewModel>(context, listen: false)
                            .getHomeMovies(initialRun: false);
                      },
                      child: Center(
                        child: Text("Unknown Error, Click to reload"),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                              width: double.infinity,
                              height: screenSize.height * 0.338,
                              child: Stack(
                                children: [
                                  CarouselSlider(
                                      items: [
                                        for (int i = 0; i < 4; i++)
                                          DiscoverCard(
                                            movie: provider.discoverMovies[i],
                                          ),
                                      ],
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          viewportFraction: 1,
                                          onPageChanged: (page, reason) {
                                            Provider.of<PageIndicatorProvider>(
                                                    context,
                                                    listen: false)
                                                .setIndex(page);
                                          })),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Consumer<PageIndicatorProvider>(
                                      builder: (context, provider, child) =>
                                          Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32,
                                          vertical: 28,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            PageIndicator(
                                              selected: provider
                                                      .selectedDiscoverPage ==
                                                  0,
                                            ),
                                            PageIndicator(
                                              selected: provider
                                                      .selectedDiscoverPage ==
                                                  1,
                                            ),
                                            PageIndicator(
                                              selected: provider
                                                      .selectedDiscoverPage ==
                                                  2,
                                            ),
                                            PageIndicator(
                                              selected: provider
                                                      .selectedDiscoverPage ==
                                                  3,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16, bottom: 16),
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
                                itemCount: provider.trendingMoviesDaily.length,
                                itemBuilder: (context, index) {
                                  if (provider.trendingMoviesDaily.isNotEmpty) {
                                    return MovieCard(
                                      movie:
                                          provider.trendingMoviesDaily[index],
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
                                itemCount: provider.trendingMoviesWeekly.length,
                                itemBuilder: (context, index) {
                                  if (provider
                                      .trendingMoviesWeekly.isNotEmpty) {
                                    return MovieCard(
                                      movie:
                                          provider.trendingMoviesWeekly[index],
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
                    );
        });
      }),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
        // Provider.of<ThemeProvider>(context, listen: false).switchTheme();
      },
      icon: Icon(Icons.menu),
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
      height: 8,
      width: 16,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: selected ? ThemeConfig.lightAccent : Color(0xFF555555),
      ),
    );
  }
}
