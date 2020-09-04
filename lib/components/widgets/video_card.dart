import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:movie_app/models/video_model.dart';
import 'package:movie_app/utilities/styles.dart';

import 'build_functions.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({
    this.video,
    this.height = 110,
    this.width = 115,
  });
  final Video video;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          FadeInImage.assetNetwork(
            width: width,
            height: height,
            placeholder: "assets/placeholder.png",
            image: getMovieUrl(video?.key),
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: backgroundBlack.withOpacity(0.35),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Feather.play_circle,
              color: themeWhite.withOpacity(0.9),
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
