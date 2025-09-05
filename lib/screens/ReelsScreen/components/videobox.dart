// videobox.dart
import 'package:eco_world/screens/ReelsScreen/components/actionbar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videobox extends StatefulWidget {
  const Videobox({super.key});

  @override
  State<Videobox> createState() => VideoboxState();
}

class VideoboxState extends State<Videobox> with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  final List<String> _urls = const [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
  ];

  final Map<int, VideoPlayerController> _controllers = {};
  int _currentIndex = 0;

  // Add these public methods
  void pauseCurrentVideo() {
    if (_controllers[_currentIndex]?.value.isPlaying ?? false) {
      _controllers[_currentIndex]?.pause();
    }
  }

  void resumeCurrentVideo() {
    if (_controllers[_currentIndex]?.value.isInitialized ?? false) {
      _controllers[_currentIndex]?.play();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeController(_currentIndex);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controllers[_currentIndex]?.pause();
    }
  }

  Future<void> _initializeController(int index) async {
    try{
if (_controllers.containsKey(index)) return;

    final controller = VideoPlayerController.networkUrl(Uri.parse(_urls[index]));
    await controller.initialize();
    controller.setLooping(true);
    controller.setVolume(0);

    if (!mounted) return;

    _controllers[index] = controller;

    if (index == _currentIndex) {
      controller.setVolume(100);
      controller.play();
    }
    setState(() {});
    }catch(e){
     print("crashed");
    }
    
  }

 void _onPageChanged(int newIndex) async {
  // Check if a video is currently playing. If so, pause it.
  final oldController = _controllers[_currentIndex];
  if (oldController != null) {
    // Explicitly set volume to 0 and pause, then wait for the pause to complete
    await oldController.setVolume(0);
    await oldController.pause();
  }
  
  // Update the current index
  _currentIndex = newIndex;

  // Pre-cache the new video and the next one to minimize loading time
  await _initializeController(newIndex);
  if (newIndex + 1 < _urls.length) {
    _initializeController(newIndex + 1);
  }

  // Dispose of controllers for videos that are far away
  final keysToDispose = _controllers.keys.toList();
  for (final key in keysToDispose) {
    if (key < _currentIndex - 1 || key > _currentIndex + 1) {
      _controllers[key]?.dispose();
      _controllers.remove(key);
    }
  }

  // Play the new video and set its volume to 100
  final newController = _controllers[_currentIndex];
  if (newController != null) {
    await newController.setVolume(100);
    await newController.play();
  }
}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controllers.values.forEach((controller) => controller.dispose());
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cs = Theme.of(context).colorScheme;
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _urls.length,
      itemBuilder: (context, index) {
        final controller = _controllers[index];
        return controller != null && controller.value.isInitialized
            ? Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SizedBox(
                        width: controller.value.size.width,
                        height: controller.value.size.height,
                        child: VideoPlayer(controller),
                      ),
                    ),
                  ),
                  const Positioned(
                      bottom: 0, right: 0, child: Actionbar()),
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.1,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: cs.onSurface,
                                    borderRadius: BorderRadius.circular(17.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            width: 250,
                            child: const Text("Some little comments to be written"),
                          )
                        ],
                      )),
                ],
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}