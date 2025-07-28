import 'package:eco_world/screens/AccountScreen/components/dropdown_list_icon.dart';
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

                      DropdownListIcon(
                        icon: const Icon(
                          Icons.pending,
                          size: 35,
                        ),
                        myActions: const [
                          {
                            "title": "See Recent Activities",
                            "icon": Icon(Icons.history),
                            "value": "History"
                          },
                          {
                            "title": "Logout",
                            "icon": Icon(Icons.logout),
                            "value": "Logout",
                          }
                        ],
                        onpresses: (value) {
                          if (value == 'Logout') {
                            _signOut(context);
                          } else if (value == 'History') {
                            print('Showing recent activities...');
                          }
                        },
                      ) // Simplified here
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
                        border:
                            Border.all(width: 0.25, color: theme.onSurface)),
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
                        DropdownListButton(text: "Add Photo", myActions: const [
                          {
                            "title": "Take Picture",
                            "icon": Icon(Icons.camera_alt),
                            "value": "Picture"
                          },
                          {
                            "title": "Pick from gallery",
                            "icon": Icon(Icons.photo),
                            "value": "Gallery"
                          },
                        ],
                        onpresses: (value) {
                          if (value == 'Picture') {
                           print("Taking new picture");
                          } else if (value == 'Gallery') {
                            print('Picking from gallery...');
                          }
                        },)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(width: 0.25, color: theme.onSurface)),
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
                              "Add bio",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Add Bio"),
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
                        border:
                            Border.all(width: 0.25, color: theme.onSurface)),
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
                              "Find others to follow",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Find Others"),
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
                        border:
                            Border.all(width: 0.05, color: theme.onSurface)),
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
                              "Upload Content",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text("Add Media"),
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
      /* {"type": "image", "url": "link"},
      {"type": "video", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"},
      {"type": "image", "url": "link"}, */
    ];
    return (media.isEmpty
        ? SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Share a moment with",
                  style: TextStyle(fontSize: 25),
                ),
                const Text(
                  "the world",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Create your first reel",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ))
              ],
            ),
          )
        : ReelReusable(mediaSource: media));
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
