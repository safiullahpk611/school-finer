import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_finder/core/enums/view_state.dart';

import '../../../../core/locator.dart';
import '../../../../core/model/appuser.dart';
import '../../../../core/model/base_view_model.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../../../core/services/database_services.dart';
import '../../set_locaton/set_location.dart';
import '../../widgets/custom_snacke_bar.dart';

class SignInProvider extends BaseViewModal {
  final _authService = locator<AuthServices>();

  AppUser appUser = AppUser();
  final databaseServices = DatabaseServices();
  CustomAuthResult customAuthResult = CustomAuthResult();
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isVisiblePassword = false;
  String selectedRole = "As admin";

  /// Visible Password =================================>>>
  ///
  ///
  visiblePassword() {
    print("Password state : $isVisiblePassword");
    isVisiblePassword = !isVisiblePassword;
    notifyListeners();
    print("Password final state : $isVisiblePassword");
  }

  loginWithEmail(AppUser appUser, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(ViewState.busy);

      _authService.customAuthResult.user = null;
      notifyListeners();
      // if (selectedRole == 'As admin') {
      //   if (appUser.userEmail == 'admin@gmail.com') {
      //     customAuthResult = await _authService.loginUser(appUser);
      //   }
      // }
      // if (selectedRole != 'As admin') {
      customAuthResult = await _authService.loginUser(appUser);

      print("user is   ${customAuthResult.user}");
      if (customAuthResult.user != null) {

        print(
            "App user Id: ${_authService.appUser.appUserId} ${customAuthResult.user!.uid}");
      
      print("Is first Login=> ${_authService.appUser.isFirstLogin}");

      appUser = _authService.appUser;
      Get.offAll(const SetLocation());
    } 
    
    else {
      showSnackBar(
        context,
        customAuthResult.errorMessage!,
        duration: 5000,
      );
    }

    setState(ViewState.idle);
  }
}
}