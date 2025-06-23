import 'package:flutter/cupertino.dart';
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
  Future <void> initializeVideoCrontroller()async{
    _videoController=VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    await _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.setVolume(100);

    if(!mounted) return;
    _videoController.play();
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
      height: height*0.2,
      width: height*0.2,
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        borderRadius: BorderRadius.circular(height*0.015),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7),blurRadius: 2,spreadRadius: 1)]
      ),
      child: VideoPlayer(_videoController),
    );
  }
}