import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/core/configs/app_typography_ext.dart';
import 'package:school_finder/core/enums/view_state.dart';
import 'package:school_finder/ui/screen/authentication/signup/sign_up_provider.dart';

import '../selection/selection_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(create: (context) {
      return SignUpProvider();
    }, child: Consumer<SignUpProvider>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: logoColor,
          centerTitle: true,
          title: Text("School finder",
              style: GoogleFonts.unbounded().s(18).cl(Colors.black)),
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
          elevation: 0,
        ),
        backgroundColor: const Color(0xfffcb575),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: primaryColor,
          ),
          inAsyncCall: model.state == ViewState.busy,
          child: SingleChildScrollView(
            child: Form(
              key: model.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Create Account Now",
                        style: GoogleFonts.unbounded().s(18).cl(Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 60),
                        decoration: BoxDecoration(
                            color: const Color(0xffce805b).withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          BorderTextField(
                            hintText: 'Full Name',
                            onChanged: (val) {
                              model.appUser.userName = val;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Full Name can't be empty";
                              }
                            },
                            suffixIcon: const Icon(Icons.person),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          BorderTextField(
                            hintText: 'Last Name',
                            onChanged: (val) {
                              model.appUser.lastName = val;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Full Name can't be empty";
                              }
                            },
                            suffixIcon: const Icon(Icons.person),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
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
                            height: 25,
                          ),
                          BorderTextField(
                            isVesiable: model.isVisiblePassword,
                            controller: model.PasswordController,
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
                            height: 25,
                          ),
                          BorderTextField(
                            isVesiable: model.isVisiblePassword,
                            hintText: 'Confirm Password',
                            onChanged: (val) {
                              model.appUser.confirmPassword;
                            },
                            controller: model.confirmPasswordController,
                            validator: (value) {
                              if (model.confirmPasswordController.text !=
                                  model.PasswordController.text) {
                                return "Password does not matched";
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
                            height: 25,
                          ),
                          DropdownButtonFormField<String>(
                            value: model.selectedRole,
                            onChanged: (String? newValue) {
                              setState(() {
                                model.selectedRole = newValue!;
                              });
                            },
                            items: <String>[
                              'Select Role', // Add a default value or prompt
                              'Gurdain',
                              'Principal'
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
                        height: 30,
                      ),
                      CustomButton(
                        title: 'Sign Up ',
                        onTap: () {
                          model.signUpUser(model.appUser, context, true, false);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      // CustomButton(
                      //   title: 'School Registration',
                      //   onTap: () {
                      //     model.signUpUser(model.appUser, context, false, true);
                      //   },
                      // ),
                    ]),
              ),
            ),
          ),
        ),
      );
    }));
  }
}

class BorderTextField extends StatelessWidget {
  final onChanged;
  final validator;
  final hintText;
  final controller;
  final maxLine;
  final suffixIcon;
  final prefixIcon;
  final autofillHints;
  final textInputAction;
  final isVesiable;

  TextInputType? keyBoardType;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  BorderTextField({
    super.key,
    this.onChanged,
    this.isVesiable = false,
    this.controller,
    this.hintText,
    this.validator,
    this.maxLine = 1,
    this.suffixIcon,
    this.prefixIcon,
    this.autofillHints,
    this.textInputAction,
    this.keyBoardType = TextInputType.text,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVesiable,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      // autocorrect: true,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(width: 2),
        ),
        suffixIcon: suffixIcon,
        // prefixIcon: Icon(
        //   prefixIcon,
        //   color: Colors.black,
        // ),
      ),
    );
  }
}
