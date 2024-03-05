import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_finder/core/model/appuser.dart';
import 'package:school_finder/core/model/princpal_profile_mode.dart';

class CustomAuthResult {
  String? errorMessage;
  User? user;
  bool? userRole;

  CustomAuthResult({
    this.errorMessage,
    this.user,
    this.userRole,
  });
}

class PrincipalDataResult {
  bool? dataAded;
  String? meessage;

  PrincpalProfileModel? princpalProfileModel;
  PrincipalDataResult(
      {this.dataAded, this.meessage, this.princpalProfileModel});
}
