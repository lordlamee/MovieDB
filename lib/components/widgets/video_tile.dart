import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/components/widgets/download_alert.dart';
import 'package:movie_app/components/widgets/video_card.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/provider/theme_provide.dart';
import 'package:movie_app/ui/video_player_screen.dart';
import 'package:provider/provider.dart';

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
              color: Provider.of<ThemeProvider>(context).darkTheme
                  ? Colors.white
                  : Colors.black,
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      video?.name,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
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
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Download Video"),
                                content: Text("Download ${video.name} ?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () async {
                                      Fluttertoast.showToast(
                                          msg: "Preparing Download",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color,
                                          textColor:
                                              Theme.of(context).primaryColor,
                                          fontSize: 16.0);
                                      bool done = await showDialog(
                                        context: context,
                                        builder: (context) => DownloadAlert(
                                          video: video,
                                        ),
                                      );
                                      if (done) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text("Yes"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"),
                                  )
                                ],
                              ));
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
