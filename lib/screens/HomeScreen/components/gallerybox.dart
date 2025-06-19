import 'package:eco_world/screens/HomeScreen/components/commentmodal.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Gallerybox extends StatefulWidget {
  const Gallerybox({super.key});

  @override
  State<Gallerybox> createState() => _GalleryboxState();
}

class _GalleryboxState extends State<Gallerybox> {
  late final PageController _controller;
  List<Widget> images = const [
    Center(child: Text("Hello1")),
    Center(child: Text("Hello2")),
    Center(child: Text("Hello3")),
  ];
  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            color: cs.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: cs.onSurface,
                            borderRadius: BorderRadius.circular(17.5)),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text("Page Name")
                    ],
                  ),
                ),
                const SizedBox(
                  child: Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
            /* color: Colors.red, */
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(controller: _controller, children: images),
                images.length > 1
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: WormEffect(
                              activeDotColor: cs.onSurface,
                              dotColor: cs.onSurface.withOpacity(0.4),
                              dotHeight: 10,
                              dotWidth: 10),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1), top: BorderSide(width: 1))),
            height: 50,
            /*  color: Colors.black, */
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const SizedBox(
                            child: Row(
                          children: [
                            Icon(Icons.favorite_border),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                      ),
                      InkWell(
                        onTap: () {
                          showCustomCommentModal(context);
                        },
                        child: const SizedBox(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.forum_outlined),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                      ),
                      InkWell(onTap: () {}, child: const Icon(Icons.share)),
                    ],
                  ),
                ),
                const Icon(Icons.save_alt_outlined),
              ],
            ),
          ),
          const SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('''Hello Maa Guy
                How ae you''')
              ],
            ),
          ),
        ],
      ),
    );
  }
}


