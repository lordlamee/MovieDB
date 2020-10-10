import 'package:flutter/cupertino.dart';
import 'package:movie_app/controllers/discover_controller.dart';
import 'package:movie_app/controllers/trending_controller.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieViewModel extends ChangeNotifier {
  List<Movie> discoverMovies = [];
  List<Movie> trendingMoviesDaily = [];
  List<Movie> trendingMoviesWeekly = [];
  ViewState viewState = ViewState.idle;
  GetStatus getStatus;

  getHomeMovies({bool initialRun}) async {
    viewState = ViewState.busy;
    if (!initialRun) {
      notifyListeners();
    }
    try {
      final discover = await DiscoverController().handleDiscoverItems();
      discoverMovies = discover["items"];
      final trendingDaily = await TrendingController().trendingMoviesDaily();
      trendingMoviesDaily = trendingDaily["items"];
      final trendingWeekly = await TrendingController().trendingMoviesWeekly();
      trendingMoviesWeekly = trendingWeekly["items"];
      viewState = ViewState.idle;
      getStatus = GetStatus.pass;
      notifyListeners();
    } catch (e) {
      print(e);
      viewState = ViewState.idle;
      getStatus = GetStatus.fail;
      notifyListeners();
    }
  }

  // changeDiscoverPage(BuildContext context, PageController controller) {
  //   if (discoverMovies.isNotEmpty) {
  //     if (Provider.of<PageIndicatorProvider>(context).selectedDiscoverPage <
  //         2) {
  //       Provider.of<PageIndicatorProvider>(context, listen: false)
  //           .increaseIndex();
  //     } else {
  //       Provider.of<PageIndicatorProvider>(context, listen: false).setIndex(0);
  //     }
  //     // assert(
  //     //     Provider.of<MovieViewModel>(context).discoverMovies.isNotEmpty);
  //     if (trendingMoviesWeekly.isNotEmpty) {
  //       controller.animateToPage(
  //         Provider.of<PageIndicatorProvider>(context, listen: false)
  //             .selectedDiscoverPage,
  //         duration: Duration(milliseconds: 500),
  //         curve: Curves.decelerate,
  //       );
  //     }
  //   }
  // }
}

enum ViewState {
  busy,
  idle,
}
enum GetStatus {
  pass,
  fail,
}
