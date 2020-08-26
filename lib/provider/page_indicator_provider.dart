import 'package:flutter/material.dart';

class PageIndicatorProvider extends ChangeNotifier {
  int selectedDiscoverPage = 0;
  pageIndicator(pageIndex) {
    selectedDiscoverPage = pageIndex;
    notifyListeners();
  }
}
