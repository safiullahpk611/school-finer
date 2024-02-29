import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:school_finder/core/model/appuser.dart';
import 'package:school_finder/core/services/auth_exception_message.dart';
import 'package:school_finder/core/services/custom_auth_result.dart';
import 'package:school_finder/core/services/database_services.dart';

class AuthServices {
  var customAuthResult = CustomAuthResult();
  final authInstant = FirebaseAuth.instance;
  bool? isLogin;
  User? user;
  AppUser appUser = AppUser();
  //VehicleDetailModel vehicleDetailModel = VehicleDetailModel();

  AuthServices() {
    //init();
  }
  final databaseServices = DatabaseServices();
  init() async {
    user = authInstant.currentUser;
    if (user != null) {
      print("User is already logged in");
      isLogin = true;
      appUser = await databaseServices.getUser(user!.uid);
      print('userId => ${appUser.appUserId}');
    } else {
      print("User is not logged in");
      isLogin = false;
    }
  }

  // //
  Future<CustomAuthResult> signUpUser(
      AppUser appUser, BuildContext context) async {
    final customAuthResult = CustomAuthResult();
    try {
      final credential = await authInstant.createUserWithEmailAndPassword(
          email: appUser.userEmail!, password: appUser.password!);
      if (credential.user != null) {
        print('================>>> User registered');
        this.appUser = appUser;
        this.appUser.appUserId = credential.user!.uid;
        isLogin = true;
        print("SignUpUserId=> ${this.appUser.appUserId}");
        await credential.user!.sendEmailVerification();
        await databaseServices.registerUser(appUser);

        this.appUser = await databaseServices.getUser(credential.user!.uid);

        print(" Hello ========>>> ${appUser.userName}");
        customAuthResult.user = credential.user;
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text(
        //         'Verification email sent. Please check your email to verify.'),
        //   ),
        // );
      }
    } catch (e) {
      print('Exception@signUpUser oooops $e');
      customAuthResult.errorMessage =
          AuthExceptionsMessages.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  /// Login User  ===================================>>>
  ///
  Future<CustomAuthResult> loginUser(AppUser appUser) async {
    print("App user email: ${appUser.userEmail}");
    print("App user Password: ${appUser.password}");

    try {
      final credentials = await authInstant.signInWithEmailAndPassword(
        email: appUser.userEmail!,
        password: appUser.password!,
      );
      print("===========>>> User logined Successfully");
      if (credentials.user != null) {
        customAuthResult.user = credentials.user;
        this.appUser = appUser;
        this.appUser.appUserId = credentials.user!.uid;
        isLogin = true;

        ///
        /// Get User ===========================>>>>
        ///
        this.appUser = await databaseServices.getUser(credentials.user!.uid);

        //vehicleDetailModel = await databaseServices.getVehicleDetail(credentials.user!.uid);
      }
    } catch (e) {
      print('Exception@LoginUser $e');
      customAuthResult.errorMessage =
          AuthExceptionsMessages.generateExceptionMessage(e);
    }
    return customAuthResult;
  }
}
