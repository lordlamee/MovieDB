import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class VideoPlayerScreen extends StatefulWidget {
//   VideoPlayerScreen({this.videoId});
//   final String videoId;
//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }
//
// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({this.videoId});
  final String videoId;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  YoutubePlayerController _controller;
  YoutubeMetaData _videoMetaData;
  PlayerState _playerState;
  double volume = 100;
  bool muted = false;
  bool ready = false;
  playerListener() {
    if (ready && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId ?? "iLnmTe5Q2Qw",
      flags: YoutubePlayerFlags(
        controlsVisibleAtStart: true,
      ),
    )..addListener(playerListener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
    // });
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
      // onExitFullScreen: () {
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // },
      builder: (context, player) {
        return Container(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: player,
          ),
        );
      },
      player: YoutubePlayer(
        onReady: () {
          ready = true;
        },
        showVideoProgressIndicator: true,
        controller: _controller,
      ),
    );
  }
}
