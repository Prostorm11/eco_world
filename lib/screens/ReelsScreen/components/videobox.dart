import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videobox extends StatefulWidget {
  const Videobox({super.key});

  @override
  State<Videobox> createState() => _VideoboxState();
}

class _VideoboxState extends State<Videobox> {
  late VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
    initVideo();
  }
  

  Future<void> initVideo() async {
    try {
      videoController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      ));

      await videoController.initialize();
      videoController.setLooping(true);
      videoController.play();
      setState(() {});
    } catch (e) {
      print("Video initialization failed: $e");
    }
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoController.value.aspectRatio,
                child: VideoPlayer(videoController),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
