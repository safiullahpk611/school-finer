import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_finder/core/locator.dart';
import 'package:school_finder/firebase_options.dart';
import 'package:school_finder/ui/screen/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School finder',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff45416A)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
