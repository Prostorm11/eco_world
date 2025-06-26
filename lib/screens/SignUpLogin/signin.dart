import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              
              cs.surface.withOpacity(0.1),
              cs.primaryContainer.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child:SizedBox(
            height: 150,
            width: 150,
            child:Lottie.asset("assets/lottie/Monkey.json") ,
          )
        ),
      ),
    );
  }
}
