import 'package:flutter/material.dart';
import 'package:movie_app/components/widgets/video_tile.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/video_model.dart';

class MediaScreen extends StatelessWidget {
  MediaScreen({this.movie, this.videos});
  final Movie movie;
  final List<Video> videos;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie?.movieName ?? "Movie Videos"),
      ),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
          itemCount: videos.length,
          itemBuilder: (context, index) {
            if (videos.isNotEmpty) {
              return VideoTile(
                video: videos[index],
              );
            } else {
              return Center(
                child: Text(
                  "No Media Available",
                  style: TextStyle(),
                ),
              );
            }
          }),
    );
  }
}
