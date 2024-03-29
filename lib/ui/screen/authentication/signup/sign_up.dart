import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              style: const TextStyle().s(20).cl(primaryColor).w(6)),
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
        backgroundColor: primaryColor,
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
                        style: const TextStyle().s(20).cl(Colors.white).w(4),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 60),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(children: [
                          BorderTextField(
                            hintText: 'First Name',
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
                              if (value!.isEmpty) {
                                return "ⓘ Please enter your password";
                              } else if (value.length < 9) {
                                return "ⓘ Password must be at least 8 characters eg: Asdf1234";
                              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return "ⓘ Password must contain at least 1 number: eg Asdf1234";
                              } else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                return "ⓘ Password must contain at least 1 letter eg: Asdf1234";
                              } else {
                                return null; // Validation passed
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
                              if (value!.isEmpty) {
                                return "Please confirm your password";
                              } else if (value !=
                                  model.confirmPasswordController.text) {
                                return "Passwords do not match";
                              } else {
                                return null; // Validation passed
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
  final label;
  final ontap;
  final readOnly;
  final inputParameter;
  TextInputType? keyBoardType;
  FocusNode? focusNode;
  Function(String)? onFieldSubmitted;

  BorderTextField({
    this.ontap,
    this.inputParameter,
    super.key,
    this.readOnly = false,
    this.label,
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
      readOnly: readOnly,
      onTap: ontap,
      obscureText: isVesiable,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      inputFormatters: inputParameter,
      // autocorrect: true,
      decoration: InputDecoration(
          // filled: true,
          // fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
          label: label,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(width: 2, color: logoColor),
          ),
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)))
          // prefixIcon: Icon(
          //   prefixIcon,
          //   color: Colors.black,
          // ),
          ),
    );
  }
}
