import 'package:eco_world/screens/ReelsScreen/components/videobox.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController pageController = PageController();
  final List<String> urls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
     'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
    
  ];

  late List<VideoPlayerController?> _controllers;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controllers = List.filled(urls.length, null);
    _initializeController(currentIndex); // Load the first video
  }

  Future<void> _initializeController(int index) async {
    if (_controllers[index] != null) return; // Already initialized

    final controller = VideoPlayerController.networkUrl(Uri.parse(urls[index]));
    await controller.initialize();
    controller.setLooping(true);
    controller.setVolume(0); // Optional: mute by default
    _controllers[index] = controller;

    if (index == currentIndex) controller.play();
    setState(() {});
  }

  void _onPageChanged(int newIndex) async {
    // Pause current
    _controllers[currentIndex]?.pause();

    // Update index
    currentIndex = newIndex;

    // Initialize current and adjacent videos
    await _initializeController(newIndex);
    if (newIndex + 1 < urls.length) _initializeController(newIndex + 1);
    if (newIndex - 1 >= 0) _initializeController(newIndex - 1);

    // Dispose far-away videos
    for (int i = 0; i < _controllers.length; i++) {
      if (i < newIndex - 1 || i > newIndex + 1) {
        _controllers[i]?.dispose();
        _controllers[i] = null;
      }
    }

    // Play current
    _controllers[newIndex]?.play();
    setState(() {});
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller?.dispose();
    }
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.vertical,
        onPageChanged: _onPageChanged,
        itemCount: urls.length,
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          return controller != null
              ? Videobox(videoController: controller)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
