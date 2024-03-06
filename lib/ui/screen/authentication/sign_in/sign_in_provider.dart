import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_finder/core/enums/view_state.dart';
import 'package:school_finder/ui/screen/gurdian_flow/google_mao_controller.dart';

import '../../../../core/locator.dart';
import '../../../../core/model/appuser.dart';
import '../../../../core/model/base_view_model.dart';
import '../../../../core/services/auth_services.dart';
import '../../../../core/services/custom_auth_result.dart';
import '../../../../core/services/database_services.dart';
import '../../gurdian_flow/googleMaps_screen.dart';
import '../../princpal_flow/prinpal_data/store_princpal_data.dart';
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
      log("selected Role is $selectedRole");
      setState(ViewState.busy);

      _authService.customAuthResult.user = null;
      notifyListeners();

      customAuthResult = await _authService.loginUser(appUser);

      // print("admin is   ${mayApp.isAdmin}");
      // print("guardin is   ${mayApp.isGurdian}");
      // print("princpal   ${mayApp.princpal}");
      if (customAuthResult.user != null) {
        AppUser mayApp =
            await databaseServices.getUser(customAuthResult.user!.uid);
        if (mayApp.isAdmin == true && selectedRole == 'As admin') {
          print("as admin is calling");
          //   appUser = _authService.appUser;
          Get.offAll(const SetLocation());
          return;
        } else if (mayApp.isGurdian == true && selectedRole == 'As Gurdain') {
          print("as Gurdain is calling");
          appUser = _authService.appUser;

          await Get.to(
              () => GoogleMapScreen(userID: customAuthResult.user!.uid));
          var loc = YourController.addressValue.value;
          print("Adress??????${YourController.addressValue.value.toString()}");
          notifyListeners();
          //   Get.offAll(const SetLocation())
          // ;
          return;
        } else if (mayApp.princpal == true && selectedRole == 'AS Principal') {
          print("as Principal is calling");
          appUser = _authService.appUser;
          print(customAuthResult.user!.uid.toString());
          Get.offAll(PrincipalData(
            princpalId: customAuthResult.user!.uid.toString(),
          ));
          return;
        } else {
          showSnackBar(
            context,
            'Check Your credentials',
            duration: 5000,
          );
        }
      } else {
        showSnackBar(
          context,
          customAuthResult.errorMessage!,
          duration: 5000,
        );
      }
    }
    setState(ViewState.idle);
  }
}
