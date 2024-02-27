import 'package:flutter/material.dart';

import '../authentication/selection/selection_screen.dart';
import '../authentication/signup/sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    print("init calling");
    super.initState();
    splashScreenDelay();
  }

  splashScreenDelay() async {
    print("splash is calling");

    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SelectionScreen()));

    // Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: const Color(0xff45416A),
      body: Center(
          child: Image.asset(
        'assets/images/logo.png',
        scale: 3,
      )),
    );
  }
}
