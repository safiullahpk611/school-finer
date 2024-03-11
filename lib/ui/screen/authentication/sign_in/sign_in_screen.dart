import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/core/configs/app_typography_ext.dart';
import 'package:school_finder/ui/screen/authentication/signup/sign_up.dart';
import 'package:school_finder/ui/screen/authentication/signup/sign_up_provider.dart';

import '../../../../core/enums/view_state.dart';
import '../selection/selection_screen.dart';
import 'sign_in_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (context) {
      return SignInProvider();
    }, child: Consumer<SignInProvider>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          backgroundColor: logoColor,
          elevation: 0,
          centerTitle: true,
          title: Text("School finder",
              style: const TextStyle().s(20).cl(primaryColor).w(6)),
        ),
        backgroundColor: const Color(0xff851D2A),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: primaryColor,
          ),
          inAsyncCall: model.state == ViewState.busy,
          child: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     // colorFilter: new ColorFilter.mode(
            //     //     Colors.black.withOpacity(0.7), BlendMode.dstATop),
            //     image: AssetImage('assets/images/blur bg.png'),
            //     fit: BoxFit.cover,
            //   ),
            //    border: Border.all(color: Colors.white)

            child: Form(
              key: model.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CustomButton(
                        //   title: 'Sign Up with Admin',
                        //   onTap: () {},
                        // ),

                        Text(
                          "Log In Now",
                          style: const TextStyle().s(25).cl(Colors.white),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          'assets/images/school visit.jpeg',
                          scale: 3,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          // decoration: BoxDecoration(
                          //     image: const DecorationImage(
                          //       // colorFilter: new ColorFilter.mode(
                          //       //     Colors.black.withOpacity(0.7), BlendMode.dstATop),
                          //       image: AssetImage('assets/images/blur bg.png'),
                          //       fit: BoxFit.cover,
                          //     ),
                          //     border: Border.all(color: Colors.white)),

                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 40),
                          decoration: const BoxDecoration(
                              color: Color(0xffB7868A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(children: [
                            BorderTextField(
                              hintText: 'Email',
                              onChanged: (val) {
                                model.appUser.userEmail = val;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email can't be empty";
                                }
                                if (!value.contains("@")) {
                                  return "Enter valid email";
                                }
                              },
                              suffixIcon: const Icon(Icons.email),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            BorderTextField(
                              isVesiable: model.isVisiblePassword,
                              hintText: 'Password',
                              onChanged: (val) {
                                model.appUser.password = val;
                              },
                              validator: (value) {
                                if (value.length < 6) {
                                  return "Password length must be 6 characters";
                                }
                              },
                              suffixIcon: InkWell(
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  model.visiblePassword();
                                },
                                child: Icon(
                                  model.isVisiblePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 20,
                                  //color: primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            DropdownButtonFormField<String>(
                              style: const TextStyle(color: Colors.black),
                              value: model.selectedRole,
                              // decoration: InputDecoration(focusedBorder: BorderSide(color: primaryColor,width: 2))),
                              onChanged: (String? newValue) {
                                setState(() {
                                  model.selectedRole = newValue!;
                                });
                              },
                              items: <String>[
                                'As admin', // Add a default value or prompt
                                'As Gurdain',
                                'AS Principal'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        // CustomButton(
                        //   title: 'Login with Guardian ',
                        //   onTap: () {},
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        CustomButton(
                          title: 'Login',
                          onTap: () {
                            model.loginWithEmail(model.appUser, context);
                          },
                        ),
                        const SizedBox(
                          height: 129,
                        ),
                      ]),
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }
}
