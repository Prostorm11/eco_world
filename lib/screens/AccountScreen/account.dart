import 'package:eco_world/screens/SignUpLogin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eco_world/screens/AccountScreen/components/reel_reusable.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String currentContent = "window";

  void changePage(String contentKey) {
    setState(() => currentContent = contentKey);
  }

  int get currentIndex => {
        "window": 0,
        "reel": 1,
        "personal": 2,
      }[currentContent]!;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Top Row with handle and icons
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Row(
                    children: [
                      Text(
                        "handle",
                        style: TextStyle(fontSize: 25),
                      ),
                      Icon(Icons.expand_more)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.add_box_outlined, size: 35),
                      const SizedBox(width: 20),
                      buildDropdownIcon(), // Simplified here
                    ],
                  ),
                ],
              ),
            ),

            // Scrollable Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Info
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: height * 0.1,
                            width: height * 0.1,
                            decoration: BoxDecoration(
                              color: theme.onSurface,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(Icons.camera, size: 35),
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("1"), Text("posts")],
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("1"), Text("followers")],
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("1"), Text("following")],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child:
                          Text("Derrick Marfo", style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 10),

                    // Edit Profile Buttons
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Edit Profile"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text("Edit Profile"),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Tab Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => changePage("window"),
                          icon: Icon(
                            Icons.window,
                            color: currentContent == "window"
                                ? Colors.blue
                                : Colors.grey,
                            size: 32,
                          ),
                        ),
                        IconButton(
                          onPressed: () => changePage("reel"),
                          icon: Icon(
                            Icons.video_library,
                            color: currentContent == "reel"
                                ? Colors.blue
                                : Colors.grey,
                            size: 32,
                          ),
                        ),
                        IconButton(
                          onPressed: () => changePage("personal"),
                          icon: Icon(
                            Icons.person_2_outlined,
                            color: currentContent == "personal"
                                ? Colors.blue
                                : Colors.grey,
                            size: 32,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Display the selected tab
                    SizedBox(
                      child: currentContent == "window"
                          ? window()
                          : currentContent == "personal"
                              ? personalVideoAndPic()
                              : myReel(),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Dropdown IconButton Widget
  Widget buildDropdownIcon() {
    return Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.pending, size: 35),
          onPressed: () async {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;
            final Offset offset = button.localToGlobal(
              Offset(0, button.size.height),
              ancestor: overlay,
            );
            dropList(context, offset);
          },
        );
      },
    );
  }

  // Dropdown Menu Logic
  void dropList(BuildContext context, Offset offset) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: const [
        PopupMenuItem<String>(
          value: 'recent',
          child: ListTile(
            leading: Icon(Icons.history),
            title: Text('See Recent Activities'),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ),
      ],
    ).then((value) async {
      if (value == 'logout') {
        _signOut(context);
        print('Logging out...');
      } else if (value == 'recent') {
        print('Showing recent activities...');
      }
    });
  }

  // Tabs Content
  Widget window() {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Complete Your Profile",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.25,color: theme.onSurface)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber),
                            ),
                            const Text(
                              "Add a profile photo",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Add Photo"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.25,color: theme.onSurface)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber),
                            ),
                            const Text(
                              "Add a profile photo",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Add Photo"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.25,color: theme.onSurface)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber),
                            ),
                            const Text(
                              "Add a profile photo",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Add Photo"),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 0.25,color: theme.onSurface)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.amber),
                            ),
                            const Text(
                              "Add a profile photo",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Add Photo"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  Widget myReel() {
    List<Map<String, dynamic>> media = [
      {"type": "image", "url": "link"},
      {"type": "video", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
    ];
    return ReelReusable(mediaSource: media);
  }

  Widget personalVideoAndPic() {
    return const Center(
      child: SizedBox(
        child: Text("Personal"),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const GetStartedScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: $e')),
      );
    }
  }
}
