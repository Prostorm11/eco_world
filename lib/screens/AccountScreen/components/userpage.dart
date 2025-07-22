import 'package:eco_world/screens/AccountScreen/components/followbutton.dart';
import 'package:eco_world/screens/AccountScreen/components/reelReusable.dart';
import 'package:eco_world/screens/ReelsScreen/components/reelbox.dart';
import 'package:flutter/material.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  List<Map<String, dynamic>> media = [];
  @override
  void initState() {
    media = [
      {"type": "image", "url": "link"},
      {"type": "video", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                        )),
                    const Text(
                      "username",
                      style: TextStyle(fontSize: 20),
                    ),
                    InkWell(
                        onTap: () {},
                        child: const Icon(Icons.more_horiz, size: 30))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          const Wrap(children: [
                            Text(
                              "Some Short Catch Phrase",
                              style: TextStyle(fontSize: 15),
                            )
                          ]),
                          InkWell(
                            child: Text(
                              "anylink",
                              style: TextStyle(color: cs.primary, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Wrap(
                            children: [
                              Text(
                                "1234,Followers 2333,Following",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const FollwButton(),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(50)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(child: Text("Posts")),
              const Divider(),
              ReelReusable(mediaSource: media)
            ],
          ),
        ),
      ),
    );
  }
}
