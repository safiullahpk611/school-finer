import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_finder/core/enums/view_state.dart';
import 'package:school_finder/core/model/base_view_model.dart';
import 'package:school_finder/core/model/princpal_profile_mode.dart';
import 'package:school_finder/core/services/database_services.dart';
import 'package:school_finder/ui/screen/widgets/custom_snacke_bar.dart';

import '../../../../core/services/custom_auth_result.dart';

class ProfileProvider extends BaseViewModal {
  PrincpalProfileModel princpalProfileModel = PrincpalProfileModel();
  final databaseServices = DatabaseServices();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final result = PrincipalDataResult();

  final formKey = GlobalKey<FormState>();
  final TextEditingController principalNameController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController schoolRegNoController = TextEditingController();
  final TextEditingController principalCNICController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  var currentIndex = 0;
  var id = "";
  ProfileProvider(princpalId) {
    id = princpalId;
    checkPrincipalProfileData(princpalId);
  }
  checkPrincipalProfileData(String princpalId) async {
    setState(ViewState.busy);
    // princpalProfileModel = PrincpalProfileModel();
    princpalProfileModel = await databaseServices.getPrincpalProfile(id);
    setState(ViewState.idle);
    notifyListeners();
    log("princ[al profile exist  ${princpalProfileModel.principalName}");
  }

  ///////////////////////set princpal profile data /////////////////////////////////////////////////////////////////////////
  storePrincpalProfileData(
      PrincpalProfileModel princpalProfileModel, BuildContext context) async {
    setState(ViewState.busy);

    princpalProfileModel.appUserId = id;
    print("id in storeprincpal is ${princpalProfileModel.appUserId}");
    PrincipalDataResult result =
        await databaseServices.storePricpalProfileData(princpalProfileModel);
    if (result.dataAded = true) {
      print("result is ${result.dataAded}");
      showSnackBar(
        context,
        '${result.meessage}',
        duration: 5000,
      );
    } else {
      princpalProfileModel = result.princpalProfileModel!;
      notifyListeners();
      showSnackBar(
        context,
        '${result.meessage}',
        duration: 5000,
      );
    }
    setState(ViewState.idle);
  }
}
