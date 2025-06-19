import 'package:eco_world/screens/AccountScreen/account.dart';
import 'package:eco_world/screens/HomeScreen/home.dart';
import 'package:eco_world/screens/NewScreen/news.dart';
import 'package:eco_world/screens/ReelsScreen/reels.dart';
import 'package:eco_world/screens/ResearchScreen/reasearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
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
            .copyWith(onSurface: const Color(0xFF321B15)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x00ece5d8))
              .copyWith(
                  surface: const Color(0x00ece5d8), onSurface: Colors.grey),
          useMaterial3: true),
      home: const _EntryState(),
    );
  }
}

class _EntryState extends StatefulWidget {
  const _EntryState();

  @override
  State<_EntryState> createState() => Entry();
}

class Entry extends State<_EntryState> {
  List<Widget> widgetOptions = [
    const HomeScreen(),
    const ReelsScreen(),
    const NewsScreen(),
    const ResearchScreen(),
    const AccountScreen(),
  ];
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
        body: widgetOptions.elementAt(_selectIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 0.25, color: cs.onSurface)),
          ),
          child: BottomNavigationBar(
              currentIndex: _selectIndex,
              onTap: _screenIndexChange,
              selectedItemColor: cs.onSurface,
              unselectedItemColor: Colors.black,
              backgroundColor: cs.surface,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.play_rectangle), label: "Reels"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: "News"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cast_for_education),
                  label: "Research",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                ),
              ]),
        ),
      ),
    );
  }
}
