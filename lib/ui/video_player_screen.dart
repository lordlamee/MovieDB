import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({this.videoId});
  final String videoId;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController _controller;
  YoutubeMetaData _videoMetaData;
  PlayerState playerState;
  double volume = 100;
  bool muted = false;
  bool ready = false;
  playerListener() {
    if (ready && mounted && !_controller.value.isFullScreen) {
      setState(() {
        playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId ?? "iLnmTe5Q2Qw",
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: true,
      ),
    )..addListener(playerListener);
    _controller.toggleFullScreenMode();
    _videoMetaData = const YoutubeMetaData();
    playerState = PlayerState.unknown;
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              _videoMetaData.title ?? "video",
              style: TextStyle(),
            ),
          ),
          body: player,
        );
      },
      player: YoutubePlayer(
        onReady: () {
          ready = true;
        },
        controlsTimeOut: Duration(seconds: 1),
        showVideoProgressIndicator: true,
        controller: _controller,
      ),
    );
  }
}
