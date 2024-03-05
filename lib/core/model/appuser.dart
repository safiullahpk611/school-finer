import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppUser {
  String? appUserId;
  String? userName;
  String? lastName;
  String? userEmail;

  String? phoneNumber;

  String? password;
  String? confirmPassword;
  bool? isFirstLogin;
  bool? isGurdian;
  bool? princpal;
  bool? isAdmin;
  String? imageUrl;

  String? address;

  AppUser(
      {this.appUserId,
      this.userEmail,
      this.imageUrl,
      this.userName,
      this.phoneNumber,
      this.password,
      this.confirmPassword,
      this.isFirstLogin,
      this.isAdmin,
      this.address,
      this.lastName,
      this.isGurdian,
      this.princpal});

  AppUser.fromJson(json, id) {
    appUserId = id;
    confirmPassword = json['confirmPassword'];

    userName = json['userName'] ?? '';

    userEmail = json['userEmail'];
    password = json['password'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'] ?? '';

    isFirstLogin = json['isFirstLogin'];
    isAdmin = json['isAdmin'];
    isGurdian = json['isGurdian'];
    princpal = json['princpal'];
    address = json['address'];
  }

  toJson() {
    return {
      'appUserId': appUserId,
      'userName': userName,
      'userEmail': userEmail,
      'phoneNumber': phoneNumber,
      'password': password,
      'isFirstLogin': isFirstLogin,
      'confirmPassword': confirmPassword,
      'isAdmin': isAdmin,
      'isGurdian': isGurdian,
      'princpal': princpal,
      'address': address,
      'lastName': lastName
    };
  }
}
