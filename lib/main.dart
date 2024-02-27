import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_finder/ui/screen/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff45416A)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
