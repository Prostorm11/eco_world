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
  int likeCounter = 0;

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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            color: cs.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: cs.onSurface,
                        borderRadius: BorderRadius.circular(17.5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Page Name",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
          ),

          // Gallery Section
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView(controller: _controller, children: images),
                if (images.length > 1)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: images.length,
                      effect: WormEffect(
                        activeDotColor: cs.onSurface,
                        dotColor: cs.onSurface.withOpacity(0.4),
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Action bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 0.5),
                bottom: BorderSide(width: 0.5),
              ),
            ),
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left actions
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          likeCounter += 1;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border, color: cs.onSurface),
                          const SizedBox(width: 4),
                          Text(
                            "$likeCounter",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        showCustomCommentModal(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.forum_outlined, color: cs.onSurface),
                          const SizedBox(width: 4),
                          const Text(
                            "2",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: Icon(Icons.share, color: cs.onSurface),
                    ),
                  ],
                ),

                // Save button
                Icon(Icons.save_alt_outlined, color: cs.onSurface),
              ],
            ),
          ),

          // Description section with expandable text
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: ExpandableText(
              text:
                  '''Hello Maa Guy Guy Guy Guy Guy Guy Guy Guy Guy Guy Guy Guy\nHow ae you''',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable expandable text widget
class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const ExpandableText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final maxLines = _expanded ? null : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final span = TextSpan(text: widget.text, style: widget.style);
        final tp = TextPainter(
          text: span,
          maxLines: 2,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = tp.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: widget.style,
              maxLines: maxLines,
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
            if (isOverflowing || _expanded)
              InkWell(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _expanded ? 'less' : 'more',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
