// main.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_world/firebase_options.dart';
import 'package:eco_world/screens/AccountScreen/account.dart';
import 'package:eco_world/screens/HomeScreen/home.dart';
import 'package:eco_world/screens/NewScreen/news.dart';
import 'package:eco_world/screens/ReelsScreen/reels.dart';
import 'package:eco_world/screens/ResearchScreen/reasearch.dart';
import 'package:eco_world/constants.dart';
import 'package:eco_world/screens/SignUpLogin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization failed: $e");
  }
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();

    if (doc.exists) {
      currentUser = UserModel.fromMap(doc.data()!);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco World',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFece5d8))
            .copyWith(onSurface: const Color(0xFF4A2B20)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A2B20))
            .copyWith(surface: const Color.fromARGB(255, 168, 105, 82)),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: FirebaseAuth.instance.currentUser == null
          ? const GetStartedScreen()
          : const EntryScreen(),
    );
  }
}

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  int _selectedIndex = 0;

  // Key to control the ReelsScreen's state
  final GlobalKey<ReelsScreenState> _reelsScreenKey = GlobalKey<ReelsScreenState>();

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),
      ReelsScreen(key: _reelsScreenKey), // Pass the key here
      const NewsScreen(),
      const ResearchScreen(),
      const AccountScreen(),
    ];
  }

  void _onTabSelected(int index) {
    // Check if the previous tab was ReelsScreen
    if (_selectedIndex == 1) {
      _reelsScreenKey.currentState?.pauseVideo();
    }

    setState(() {
      _selectedIndex = index;
    });

    // Check if the new tab is ReelsScreen
    if (index == 1) {
      _reelsScreenKey.currentState?.resumeVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.25, color: cs.onSurface)),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onTabSelected,
            selectedItemColor: cs.onSurface,
            unselectedItemColor:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.black54,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF4A2B20)
                : cs.surface,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.play_rectangle), label: "Reels"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper), label: "News"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), label: "Research"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Account"),
            ],
          ),
        ),
      ),
    );
  }
}