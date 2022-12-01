import 'package:flutter/material.dart';
import 'package:on_graph_assesment/constant/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class NewVideoPlayer extends StatefulWidget {
  final String url;

  const NewVideoPlayer({Key? key, required this.url}) : super(key: key);

  @override
  State<NewVideoPlayer> createState() => _NewVideoPlayerState();
}

class _NewVideoPlayerState extends State<NewVideoPlayer> {
  late VideoPlayerController _playerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(widget.url)
      ..addListener(() {});

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _playerController.initialize();

    _playerController.setVolume(1);
    _playerController.play();
    _playerController.setLooping(true);
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return OutVideoPlayer(
            controller: _playerController,
          );
        } else {
          return Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey[400]!,
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                color: Colors.grey[600],
              ));
        }
      },
    );
  }
}

class OutVideoPlayer extends StatefulWidget {
  const OutVideoPlayer({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  State<OutVideoPlayer> createState() => _OutVideoPlayerState();
}

class _OutVideoPlayerState extends State<OutVideoPlayer> {
  bool iconVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double aspectRatio = widget.controller.value.aspectRatio;
    final bool isPlaying = widget.controller.value.isPlaying;
    final bool isPortrait = widget.controller.value.aspectRatio < 1;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: isPortrait ? size.width : null,
          height: isPortrait ? size.height : null,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
        ),
        InkWell(
          onTap: () async {
            iconVisible = true;
            setState(() {});
            if (isPlaying) {
              widget.controller.pause();
              setState(() {});
            } else {
              widget.controller.play();
              setState(() {});
            }
            await Future.delayed(const Duration(milliseconds: 1000));
            iconVisible = false;
            setState(() {});
          },
          child: SizedBox(
            width: isPortrait ? size.width : null,
            height: isPortrait ? size.height : null,
            child: Center(
              child: Visibility(
                visible: iconVisible,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black45,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 26,
                    color: white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
