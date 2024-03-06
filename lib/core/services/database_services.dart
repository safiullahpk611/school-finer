import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_finder/core/model/appuser.dart';
import 'package:school_finder/core/model/school_reg.dart';
import 'package:school_finder/core/services/custom_auth_result.dart';

import '../model/princpal_profile_mode.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;

  ///
  /// Add user
  ///
  registerUser(AppUser appUser) {
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }
/////////////////////////// reg school data //////////////////////////////////

  registerSchool(SchoolRegModel appUser) {
    try {
      firebaseFireStore
          .collection("schools")
          .doc(appUser.princpalId)
          .set(appUser.toJson());
      print("data added");
    } catch (e) {
      print('Exception $e');
    }
  }

//
//16RyK1XYT7SWFrlZb8j41rBbgMp2
  ///
  /// Get user
  ///
  Future<AppUser> getUser(id) async {
    print('GetUser id: $id');
    try {
      final snapshot =
          await firebaseFireStore.collection('AppUser').doc(id).get();
      // print('Current app User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser $e');
      return AppUser();
    }
  }

  ///////////////////////////////////princpal Profile collection///////////////////////////////
  bool dataAdded = false;
  final principalDataResult = PrincipalDataResult();
  final firebaseInstance =
      FirebaseFirestore.instance.collection('princpalProfile');

  Future<PrincipalDataResult> storePricpalProfileData(
      PrincpalProfileModel princpalProfileModel) async {
    print(
        "princpal idoooooooooooooooooooooooo ${princpalProfileModel.appUserId}");

    try {
      // QuerySnapshot querySnapshot = await firebaseInstance

      DocumentSnapshot snapshot = await firebaseFireStore
          .collection('princpalProfile')
          .doc(princpalProfileModel.appUserId)
          .get();
      if (snapshot.data() != null) {
        print("data already existmmmmmmmmmmmmmmmmmmmmm  ${snapshot.data()}");
        // Token already exists in Firestore
        principalDataResult.dataAded = true;
        principalDataResult.meessage = "Data already exists";
        principalDataResult.princpalProfileModel =
            PrincpalProfileModel.fromJson(
                snapshot.data()!, princpalProfileModel.appUserId);
        print(
            "data already exist  ${principalDataResult.princpalProfileModel!.phoneNumber}");
      } else {
        // Token doesn't exist, save it
        print("princpal id ${princpalProfileModel.appUserId}");
        print("princpal id ${princpalProfileModel.principalName}");
        print("schoolName id ${princpalProfileModel.schoolName}");
        print("schoolRegNo id ${princpalProfileModel.schoolRegNo}");
        print("phoneNumber id ${princpalProfileModel.phoneNumber}");
        print("cnic id ${princpalProfileModel.cnic}");
        firebaseFireStore
            .collection('princpalProfile')
            .doc(princpalProfileModel.appUserId)
            .set(princpalProfileModel.toJson());
        principalDataResult.dataAded = false;
        principalDataResult.meessage = "Data stored successfully";
        principalDataResult.princpalProfileModel =
            await getPrincpalProfile(princpalProfileModel.appUserId);
      }
    } catch (e) {
      print("databaseException error in princpalProfile  $e");
      principalDataResult.dataAded = false;
      principalDataResult.meessage = "databaseException error ";
    }
    return principalDataResult;
  }

  ///////////////////////////////////check princpal profile ////////////////////////////////////
  ///
  Future<PrincpalProfileModel> getPrincpalProfile(princpalId) async {
    print("data already exist111111111111111111111111111  $princpalId");
    try {
      DocumentSnapshot snapshot = await firebaseFireStore
          .collection('princpalProfile')
          .doc(princpalId)
          .get();
      print(
          "data already exist22222222222222222222222222222  ${snapshot.data()}");
      // Token already exists in Firestore
      if (snapshot != null) {
        return PrincpalProfileModel.fromJson(snapshot.data()!, princpalId);
      } else {
        return PrincpalProfileModel();
      }
    } catch (e) {
      print("error occured $e");
      return PrincpalProfileModel();
    }
  }
}
