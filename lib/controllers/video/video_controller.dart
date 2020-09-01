import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/networking/api.dart';

class VideoController {
  Api api = Api();
  videos(String movieId) async {
    dynamic videoResults = await api.getVideos(movieId);
    if (videoResults["status"] == "success") {
      List<dynamic> videoList = videoResults["results"];
      List<Video> videos = [];
      for (Map<String, dynamic> movie in videoList) {
        Video trailer = Video.fromJson(movie);
        videos.add(trailer);
      }
      return {
        "status": "success",
        "items": videos,
      };
    } else {
      return {
        "status": "fail",
        "status_message": videoResults["status_message"]
      };
    }
  }
}
