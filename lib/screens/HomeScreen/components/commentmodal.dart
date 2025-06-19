import 'package:flutter/material.dart';

void showCustomCommentModal(BuildContext context) {
  showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black.withOpacity(0.2), // Optional: slight blur
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
              ),
            ),
            DraggableScrollableSheet(
              expand: true,
                initialChildSize: 0.7, // Starts at 50% screen height
                minChildSize: 0.3,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                         Center(
                                child: Container(
                                  width: 40,
                                  height: 3,
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: const Text("Comments")),
                              ),
                        Expanded(
                          child: ListView(
                            controller: scrollController,
                            children: [
                             
                              comment(context),
                              comment(context),
                              comment(context),
                              comment(context),
                              comment(context),
                              comment(context),
                              comment(context),
                              comment(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })
          ],
        );
      });
}

Widget comment(BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 3),
    color: Colors.amber,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: cs.onSurface, borderRadius: BorderRadius.circular(20)),
        ),
        const Expanded(
          
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name"),
                Text('''Comments are ffffffffffffffffffgggggggggggggggggggggggggggggggggggggggggg
Here and ther
Now or never''')
              ],
            ),
          ),
        )
      ],
    ),
  );
}

