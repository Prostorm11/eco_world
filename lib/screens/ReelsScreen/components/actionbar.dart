import 'package:eco_world/screens/HomeScreen/components/commentmodal.dart';
import 'package:flutter/material.dart';

class Actionbar extends StatefulWidget {
  const Actionbar({super.key});

  @override
  State<Actionbar> createState() => _ActionbarState();
}

class _ActionbarState extends State<Actionbar> {
    int likeCounter=0;
    int commentCounter=0;
    int sharedCounter=0;
   
  @override
  Widget build(BuildContext context) {
    final cs=Theme.of(context).colorScheme;
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.40,
      width: MediaQuery.of(context).size.height*0.075,
      
      child:  Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 InkWell(
                  onTap: () {
                    setState(() {
                      likeCounter++;
                    });
                  },
                  child: Icon(Icons.favorite_border,size: 30,color: cs.onSurface,)),
                Text("$likeCounter")
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 InkWell(
                  onTap: () {
                    showCustomCommentModal(context);
                  },
                  child: Icon(Icons.forum_outlined,size: 30,color: cs.onSurface,)),
                Text("$commentCounter")
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 InkWell(
                  onTap: () {
                    
                  },
                  child: Icon(Icons.share,size: 30,color: cs.onSurface)),
                Text("$sharedCounter")
              ],
            ),
          ),
           Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.more_horiz,size: 30,color: cs.onSurface),
              ],
            ),
          ),

         
        ],
      ),
    );
  }
}