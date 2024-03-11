import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/core/locator.dart';
import 'package:school_finder/firebase_options.dart';
import 'package:school_finder/ui/screen/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ui/screen/princpal_flow/prinpal_data/school_reg/scholl_reg_provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SchoolRegProvider>(
            create: (context) => SchoolRegProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School finder',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
