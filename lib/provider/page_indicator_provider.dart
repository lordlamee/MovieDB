import 'package:flutter/material.dart';

class PageIndicatorProvider extends ChangeNotifier {
  int selectedDiscoverPage = 0;
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
