import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_extractor/youtube_extractor.dart';

class VideoHandler {
  YoutubeExplode youtubeExplode = YoutubeExplode();
  YouTubeExtractor youTubeExtractor = YouTubeExtractor();
  getMetaData(String videoId) async {
    var video = await youtubeExplode.videos.get(videoId);
  }

  getStream(String videoId) async {
    var streamInfo = await youTubeExtractor.getMediaStreamsAsync(videoId);
    print(streamInfo.muxed.first.size);
  }
}
