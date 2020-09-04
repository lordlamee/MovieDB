import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/video_card.dart';
import 'package:movie_app/controllers/video/video_handler.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/ui/video_player_screen.dart';

class VideoTile extends StatelessWidget {
  VideoTile({this.video});
  final Video video;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => VideoPlayerScreen(
                      videoId: video.key,
                    ),
                  ));
            },
            child: VideoCard(
              video: video,
              height: 150,
              width: 130,
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).textTheme.bodyText1.color,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    video?.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.file_download,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text(
                      "Download",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () async {
                      VideoHandler videoHandler = VideoHandler();
                      await videoHandler.downloadVideo(
                        video,
                        (received, total) {
                          //:todo handle downloading
                          print(received);
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        video?.type,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        video?.site,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
