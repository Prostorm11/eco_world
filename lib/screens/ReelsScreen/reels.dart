import 'package:eco_world/screens/ReelsScreen/components/reelbox.dart';
import 'package:eco_world/screens/ReelsScreen/components/videobox.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  bool videoboxtapped = false;
  bool rectangleReelVisible = false;

  @override
  Widget build(BuildContext context) {
    List myitem = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16];

    return Scaffold(
        body: videoboxtapped
            ? const Videobox()
            : SingleChildScrollView(
                child: Wrap(children: [
                  for (int i = 0; i < myitem.length; i += 5) ...[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        i >= myitem.length
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    videoboxtapped = true;
                                  });
                                },
                                child: const Reelbox()),
                        i + 1 >= myitem.length
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    videoboxtapped = true;
                                  });
                                },
                                child: const Reelbox(),
                              ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        i + 2 >= myitem.length
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    videoboxtapped = true;
                                  });
                                },
                                child: const Reelbox()),
                        i + 3 >= myitem.length
                            ? const SizedBox.shrink()
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    videoboxtapped = true;
                                  });
                                },
                                child: const Reelbox()),
                      ],
                    ),
                    i + 4 >= myitem.length
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              setState(() {
                                videoboxtapped = true;
                              });
                            },
                            child: VisibilityDetector(
                                key: const Key('rectangleReel'),
                                onVisibilityChanged: (info) {
                                  if (info.visibleFraction > 0.7) {
                                    setState(() {
                                      rectangleReelVisible = true;
                                    });
                                  }
                                  
                                },
                                child:  ReelboxRectangular(playVideo: rectangleReelVisible,))),
                  ]
                ]),
              ));
  }
}
