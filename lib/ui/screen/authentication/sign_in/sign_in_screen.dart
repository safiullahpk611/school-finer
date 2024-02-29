import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
              style: GoogleFonts.unbounded().s(18).cl(Colors.black)),
        ),
        backgroundColor: const Color(0xfffcb575),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: primaryColor,
          ),
          inAsyncCall: model.state == ViewState.busy,
          child: Form(
            key: model.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CustomButton(
                      //   title: 'Sign Up with Admin',
                      //   onTap: () {},
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Log In Now",
                        style: GoogleFonts.unbounded().s(25).cl(Colors.black),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        'assets/images/school visit.jpeg',
                        scale: 3,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 40),
                        decoration: BoxDecoration(
                            color: const Color(0xffce805b).withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
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
                            value: model.selectedRole,
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
                        height: 40,
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
                        height: 30,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
    }));
  }
}
