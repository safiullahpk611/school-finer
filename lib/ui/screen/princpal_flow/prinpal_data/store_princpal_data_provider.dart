import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_finder/core/model/base_view_model.dart';
import 'package:school_finder/core/model/princpal_profile_mode.dart';
import 'package:school_finder/core/services/database_services.dart';
import 'package:school_finder/ui/screen/widgets/custom_snacke_bar.dart';

import '../../../../core/services/custom_auth_result.dart';

class StorePrincpalDataProvider extends BaseViewModal {
  PrincpalProfileModel princpalProfileModel = PrincpalProfileModel();
  final databaseServices = DatabaseServices();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final result = PrincipalDataResult();
  var currentIndex = 3;
  StorePrincpalDataProvider(princpalId) {
    checkPrincipalProfileData(princpalId);
  }
  checkPrincipalProfileData(String princpalId) async {
    princpalProfileModel =
        await databaseServices.getPrincpalProfile(princpalId);
    log("princ[al profile exist  ${princpalProfileModel.principalName}");
  }

  ///////////////////////set princpal profile data /////////////////////////////////////////////////////////////////////////
  storePrincpalProfileData(
      PrincpalProfileModel princpalProfileModel, BuildContext context) async {
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
      showSnackBar(
        context,
        '${result.meessage}',
        duration: 5000,
      );
    }
  }
}
