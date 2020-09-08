import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/download_model.dart';

class DownloadsProvider extends ChangeNotifier {
  List<Download> allDownloads;
  setDownloads(List<Download> downloads) {
    allDownloads = downloads;
    notifyListeners();
  }
}
