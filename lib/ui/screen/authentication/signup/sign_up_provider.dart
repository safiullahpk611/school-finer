import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_finder/core/enums/view_state.dart';
import 'package:school_finder/core/model/appuser.dart';
import 'package:school_finder/core/services/auth_services.dart';
import 'package:school_finder/core/services/custom_auth_result.dart';
import 'package:school_finder/ui/screen/set_locaton/set_location.dart';
import 'package:school_finder/ui/screen/widgets/custom_page_route.dart';
import 'package:school_finder/ui/screen/widgets/custom_snacke_bar.dart';

import '../../../../core/locator.dart';
import '../../../../core/model/base_view_model.dart';

class SignUpProvider extends BaseViewModal {
  bool isVisiblePassword = false;
  final _authServices = locator<AuthServices>();

  CustomAuthResult customAuthResult = CustomAuthResult();
  AppUser appUser = AppUser();
  final formKey = GlobalKey<FormState>();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String selectedRole = "Select Role";

  /// Visible Password =================================>>>
  ///
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  signUpUser(
      AppUser appUser, BuildContext context, bool? gurdain, princpal) async {
    if (formKey.currentState!.validate()) {
      setState(ViewState.busy);
      // sign up user

      appUser.isGurdian = selectedRole == 'Gurdain' ? true : false;
      appUser.princpal = selectedRole == 'Principal' ? true : false;
      print("User Name: ${appUser.userName}");
      print("User Email: ${appUser.userEmail}");
      print("User Password: ${appUser.password}");
      print("gurdian is $gurdain");
      print("princpal is $princpal");
      print("User ConfirmPassword: ${appUser.confirmPassword}");
      appUser.isFirstLogin = true;

      appUser.isAdmin = false;

      appUser.isFirstLogin = true;

      ///
      /// generate token ===================================>>>
      ///
      customAuthResult = await _authServices.signUpUser(appUser, context);
      setState(ViewState.idle);
      if (customAuthResult.user != null) {
        print("SignUpUserId=> ${_authServices.appUser.appUserId}");

        Get.offAll(const SetLocation());

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   CustomPageRoute(
        //       child: isAdmin == true
        //           ? AdminPanelBottomNavigationBar()
        //           : UserFormFillScreen()),
        //   (Route route) => false,
        // );
      } else {
        showSnackBar(context, customAuthResult.errorMessage!);
      }
    }
  }
}
