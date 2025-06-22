import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videobox extends StatelessWidget {
  final VideoPlayerController videoController;
  const Videobox({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: videoController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: VideoPlayer(videoController),
            )
          : const CircularProgressIndicator(),
    );
  }
}
