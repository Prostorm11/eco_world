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
      margin: const EdgeInsets.all(1),
      height: height*0.15,
      width: width*0.325,
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
       
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7),blurRadius: 2,spreadRadius: 1)]
      ),
      child: VideoPlayer(_videoController),
    );
  }
}

class ReelboxRectangular extends StatefulWidget {
  const ReelboxRectangular({super.key});

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
      margin: const EdgeInsets.symmetric(horizontal: 1,vertical: 2),
      height: height*0.3,
      width: width*0.325,
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
       
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.7),blurRadius: 2,spreadRadius: 1)]
      ),
      child: VideoPlayer(_videoController),
    );
  }
}