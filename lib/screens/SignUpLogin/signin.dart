import 'dart:async';
import 'package:eco_world/main.dart';
import 'package:eco_world/screens/SignUpLogin/completeProfile.dart';
import 'package:eco_world/screens/SignUpLogin/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
/* import 'package:firebase_auth/firebase_auth.dart'; */
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  int _textIndex = 0;

  final List<String> _texts = [
    "Pulse of the planet.",
    "Connect through nature."
  ];
  late Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _textIndex = (_textIndex + 1) % _texts.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "ECO",
                        style: TextStyle(
                          color: Colors.green, // Always green
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "nnect",
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface, // Adaptive
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                child:
                    Lottie.asset("assets/lottie/Monkey.json", fit: BoxFit.fill),
              ),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    _texts[_textIndex],
                    key: ValueKey<String>(_texts[_textIndex]),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SigninScreen()));
                  },
                  child: const Text("Get Started"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool siginingIN = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
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
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: cs.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          // You can use cs.onBackground for dynamic theming
                        ),
                        border: InputBorder.none, // 👈 Remove internal border
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      signInFunction(context);
                    },
                    child: siginingIN
                        ? const CircularProgressIndicator()
                        : const Text("Sign In"),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignupScreen()));
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: cs.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInFunction(BuildContext context) async {
    setState(() {
      siginingIN = !siginingIN;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      setState(() {
        siginingIN = !siginingIN;
      });
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const EntryScreen()),
      );
      /*   Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const NameUsernameScreen()),
      ); */
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }
      if (mounted) {
        setState(() {
          siginingIN = !siginingIN;
        });
      }

      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sign In Failed'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }
}
