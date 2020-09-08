import 'dart:io';
import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/models/download_model.dart';
import 'package:movie_app/models/video_model.dart' as VideoModel;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoHandler {
  YoutubeExplode youtubeExplode = YoutubeExplode();

  getMetaData(String videoId) async {
    var video = await youtubeExplode.videos.get(videoId);
    if (video != null) {
      return video;
    } else {
      return "null";
    }
  }

  getStreamInfo(String videoId) async {
    var streamData =
        await youtubeExplode.videos.streamsClient.getManifest(videoId);
    if (streamData != null) {
      var streamInfo = streamData.muxed.first;
      print(streamInfo);
      return streamInfo;
    } else {
      return "null";
    }
  }

  getFilePath(fileName) async {
    Directory directory = await getExternalStorageDirectory();
    return "${directory.path}/Downloads/$fileName.mp4";
  }

  downloadVideo(BuildContext context, VideoModel.Video video,
      Function(double) progressReceiveFunction) async {
    Dio dio = Dio();
    var status = await Permission.storage.status;
    if (status.isDenied || status.isUndetermined) {
      await Permission.storage.request();
    }
    var streamLink = await getStreamInfo(video.key);
    var filePath = await getFilePath(video.name);
    await dio.download(streamLink.url.toString(), filePath,
        onReceiveProgress: (received, total) {
      double progress = (received / total * 100);
      progressReceiveFunction(progress);
      if (received == total) {
        Download download = Download.fromMap({
          DatabaseProvider.COLUMN_NAME: video.name,
          DatabaseProvider.COLUMN_PATH: filePath,
        });
        DatabaseProvider.db.saveDownload(download);
      }
    });
  }
}
