import 'package:flutter/material.dart';

class PageIndicatorProvider extends ChangeNotifier {
  int selectedDiscoverPage = 0;
  int get pageIndex => selectedDiscoverPage;
  pageIndicator(int pageIndex) {
    selectedDiscoverPage = pageIndex;
    notifyListeners();
  }

  increaseIndex() {
    selectedDiscoverPage++;
    notifyListeners();
  }

  setIndex(int index) {
    selectedDiscoverPage = index;
    notifyListeners();
  }
}
