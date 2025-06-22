import 'package:eco_world/screens/ReelsScreen/components/actionbar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videobox extends StatelessWidget {
  final VideoPlayerController videoController;
  const Videobox({super.key, required this.videoController});

  @override
  Widget build(BuildContext context) {
    return videoController.value.isInitialized
        ? Stack(
            children: [
              SizedBox.expand( // Make it full screen
                child: FittedBox(
                  fit: BoxFit.fill, // Makes sure the video covers the screen
                  child: SizedBox(
                    width: videoController.value.size.width,
                    height: videoController.value.size.height,
                    child: VideoPlayer(videoController),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: Actionbar())
            ],
          )
        : const Center(child:  CircularProgressIndicator());
  }
}
