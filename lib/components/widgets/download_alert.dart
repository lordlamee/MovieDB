import 'package:flutter/material.dart';
import 'package:movie_app/controllers/video/video_handler.dart';
import 'package:movie_app/models/video_model.dart';

class DownloadAlert extends StatefulWidget {
  final Video video;
  DownloadAlert({this.video});
  @override
  _DownloadAlertState createState() => _DownloadAlertState();
}

class _DownloadAlertState extends State<DownloadAlert> {
  double progress = 0;
  download() async {
    VideoHandler videoHandler = VideoHandler();
    await videoHandler.downloadVideo(context, widget.video, (downloadProgress) {
      setState(() {
        progress = downloadProgress;
      });
      if (progress == 100) {
        Navigator.pop(context, true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    download();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SimpleDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        title: Text(
          "Downloading...",
          style: TextStyle(),
        ),
        children: [
          LinearProgressIndicator(
            minHeight: 8,
            value: progress / 100,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "${progress.floor()} %",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
