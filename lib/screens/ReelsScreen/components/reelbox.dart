import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Reelbox extends StatefulWidget {
  const Reelbox({super.key});

  @override
  State<Reelbox> createState() => _ReelboxState();
}

class _ReelboxState extends State<Reelbox> {
  late VideoPlayerController _videoController;
  @override
  void initState() {
    initializeVideoCrontroller();
    super.initState();
  }
  Future<void> initializeVideoCrontroller() async {
  try {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
    );

    await _videoController.initialize();
    _videoController.setLooping(false);
    _videoController.setVolume(0.5); // Volume is between 0.0 and 1.0

    if (!mounted) return;

    setState(() {
      // You can show the initialized video player here
    });
  } catch (e, stackTrace) {
    // 👇 Optional: print or log the error
    print('Video initialization failed: $e');
    print(stackTrace);

    // 👇 Show a fallback UI or message to the user
    if (mounted) {
      setState(() {
        // Maybe show an error placeholder instead of the video

      });
    }
  }
}


   @override
  void dispose() {
   
    _videoController.dispose();
    super.dispose();
  } 
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return  Container(
      margin: const EdgeInsets.all(1),
      height: height*0.15,
      width: width*0.325,
      decoration: BoxDecoration(
        color: Colors.transparent,
       
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7),blurRadius: 2,spreadRadius: 1)]
      ),
      child: VideoPlayer(_videoController),
    );
  }
}

class ReelboxRectangular extends StatefulWidget {
  final bool playVideo;
  const ReelboxRectangular({super.key,required this.playVideo});

  @override
  State<ReelboxRectangular> createState() => _ReelboxRectangularState();
}

class _ReelboxRectangularState extends State<ReelboxRectangular> {
  late VideoPlayerController _videoController; 
   @override
  void initState() {
    initializeVideoCrontroller();
    super.initState();
  }
  Future <void> initializeVideoCrontroller()async{
    _videoController=VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    await _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.setVolume(100);

    if(!mounted) return;
    if(widget.playVideo){
    _videoController.play();
    }
  
    setState(() {
      
    });
  }

   @override
  void dispose() {
   
    _videoController.dispose();
    super.dispose();
  }  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 1,vertical: 2),
      height: height*0.3,
      width: width*0.325,
      decoration: BoxDecoration(
        color: Colors.transparent,
       
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7),blurRadius: 2,spreadRadius: 1)]
      ),
      child: VideoPlayer(_videoController),
    );
  }
}