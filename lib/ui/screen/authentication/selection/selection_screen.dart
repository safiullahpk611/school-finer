import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_finder/core/configs/app_typography_ext.dart';

import 'package:school_finder/ui/screen/authentication/selection/role_selction.dart';
import '../../../../core/color.dart';
import '../sign_in/sign_in_screen.dart';
import '../signup/sign_up.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xfffcb575),
      appBar: AppBar(
        backgroundColor: const Color(0xfffcb575),
        //  leading: Image.asset('assets/images/logo.png'),
        // backgroundColor: logoColor.withOpacity(0.8),
        elevation: 0,
        centerTitle: true,
        title: Text("School Finder", style: TextStyle().s(20).cl(Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.015,
            ),
            Center(
                child: Image.asset('assets/images/schoo-finder (1).png',
                    height: size.height * 0.2)),
            const SizedBox(height: 40),

            Text("Hello, Welcome !",
                style: TextStyle().s(28).cl(Colors.black).w(6)),
            const SizedBox(height: 20),
            Text(
              "To SchoolFinder Top platform for finding Schools",
              style: TextStyle().s(18).cl(Colors.black).w(4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            //

            CustomButton(
              title: 'Log In',
              onTap: () {
                Get.to(const SignInScreen());
              },
            ),
            const SizedBox(height: 20),
            // Spacer between buttons

            CustomButton(
              title: 'Sign Up',
              onTap: () {
                Get.to(const SignUpScreen());
              },
            ),
            const Expanded(child: SizedBox())
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final title;
  final onTap;

  const CustomButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: logoColor),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: TextStyle().s(18).cl(primaryColor),
          ),
        ),
      ),
    );
  }
}
