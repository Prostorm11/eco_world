import 'package:eco_world/screens/HomeScreen/components/advertisementbox.dart';
import 'package:eco_world/screens/HomeScreen/components/gallerybox.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  var cs=Theme.of(context).colorScheme;
    return Container(
      color:cs.onPrimary ,
      child: const SingleChildScrollView(
          child: Column(
        children: [
          Advertisementbox(),
          Gallerybox(),
          Gallerybox(),
          Gallerybox(),
          Gallerybox(),
        ],
      )),
    );
  }
}
