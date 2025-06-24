import 'package:eco_world/screens/ReelsScreen/components/reelbox.dart';
import 'package:eco_world/screens/ReelsScreen/components/videobox.dart';
import 'package:flutter/material.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  bool videoboxtapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: InkWell(
            onTap: () {
              setState(() {
                videoboxtapped = true;
              });
            },
            child: videoboxtapped ? const Videobox() : 
            const Wrap(children: [ Column(
               mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Reelbox(),
                Reelbox(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Reelbox(),
                Reelbox(),
              ],
            ),
            ReelboxRectangular()
            
            
            ])));
  }
}
