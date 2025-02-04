import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostedVideoPlayer extends StatefulWidget {
  final String id;
  const PostedVideoPlayer({
    super.key,
    required this.id,
  });

  @override
  State<PostedVideoPlayer> createState() => _PostedVideoPlayerState();
}

class _PostedVideoPlayerState extends State<PostedVideoPlayer> {
  late final YoutubePlayerController _controller;
  String _id = "";
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  final bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _id = widget.id;
    _controller = YoutubePlayerController(
      initialVideoId: _id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        disableDragSeek: false,
      ),
    )..addListener(listener);

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Theme.of(context).primaryColor,
    );
  }
}
