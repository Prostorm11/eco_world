
import 'package:flutter/material.dart';

class FollwButton extends StatefulWidget {
  const FollwButton({super.key});

  @override
  State<FollwButton> createState() => _FollwButtonState();
}

class _FollwButtonState extends State<FollwButton> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 45,
      width: 150,
      child: 
      ElevatedButton(onPressed: (){}, 
      style: ElevatedButton.styleFrom(
       
        shape:RoundedRectangleBorder(
          
          borderRadius: BorderRadius.circular(6)
        )
      ),
      child: const Text("Follow")),
    );
  }
}