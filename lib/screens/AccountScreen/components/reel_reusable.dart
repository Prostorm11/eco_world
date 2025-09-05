import 'package:eco_world/screens/ReelsScreen/components/reelbox.dart';
import 'package:flutter/material.dart';

class ReelReusable extends StatefulWidget {
  final List mediaSource;
  const ReelReusable({super.key,required this.mediaSource});

  @override
  State<ReelReusable> createState() => _ReelReusableState();
}

class _ReelReusableState extends State<ReelReusable> {
  @override
  Widget build(BuildContext context) {
   /*  List<Map<String, dynamic>> media = []; */
  @override
  void initState() {
   /*  media = [
      {"type": "image", "url": "link"},
      {"type": "video", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
    ]; */
    super.initState();
  }

    return  Wrap(
               
                children: widget.mediaSource.map((item) {
                  final String type = item['type'];
                  final String url = item['url'];

                  if (type == 'image') {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 2),
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.325,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                blurRadius: 2,
                                spreadRadius: 1)
                          ]),
                    );
                  } else if (type == 'Picture') {
                    return const Text('Unknown type');
                  } else {
                    return const Reelbox();
                  }
                }).toList(),
              );
  }
}