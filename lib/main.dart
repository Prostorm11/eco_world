/* import 'package:eco_world/firebase_options.dart'; */
import 'package:eco_world/firebase_options.dart';
import 'package:eco_world/screens/AccountScreen/account.dart';
import 'package:eco_world/screens/AccountScreen/components/userpage.dart';
import 'package:eco_world/screens/HomeScreen/home.dart';
import 'package:eco_world/screens/NewScreen/news.dart';
import 'package:eco_world/screens/ReelsScreen/reels.dart';
import 'package:eco_world/screens/ResearchScreen/reasearch.dart';
import 'package:eco_world/screens/SignUpLogin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';     
/* import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    runApp(const MyApp());
  } catch (e) {
   print("No Connection");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFece5d8))
            .copyWith(onSurface: const Color(0xFF4A2B20)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A2B20))
              .copyWith(
                  surface: const Color.fromARGB(255, 168, 105, 82), ),
          useMaterial3: true),
      themeMode: ThemeMode.system,
      home: FirebaseAuth.instance.currentUser == null
    ? const GetStartedScreen()
    : const EntryScreen(),
    
    );
  }
}

class EntryScreen extends StatefulWidget {
  const  EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => Entry();
}

class Entry extends State<EntryScreen> {
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ReelsScreen();
      case 2:
        return const NewsScreen();
      case 3:
       /*  return const UserPageScreen(); */
       return const ResearchScreen();
      case 4:
        return const AccountScreen();
      default:
        return const HomeScreen();
    }
  }

  int _selectIndex = 0;

  void _screenIndexChange(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _getScreen(_selectIndex),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 0.25, color: cs.onSurface)),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectIndex,
              onTap: _screenIndexChange,
              selectedItemColor: cs.onSurface,
              unselectedItemColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.black54,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF4A2B20) // a soft dark brown background
                  : cs.surface,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.play_rectangle), label: "Reels"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: "News"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: "Research",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
              ],
            )),
      ),
    );
  }
}
