import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_finder/core/enums/view_state.dart';
import 'package:school_finder/core/model/base_view_model.dart';
import 'package:school_finder/core/model/school_reg.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/school_reg/availability.dart';

import '../../../../../core/services/database_services.dart';

class SchoolRegProvider extends BaseViewModal {
  String setTimeSlot = '04/5/2024 on 10:50 am';

  final List<File> imageFiles = [];
  List<String> imagePaths = [];
  final List<File> pastMatriculationImages = [];
  List<String> pastMatriculationImagesPath = [];
  final picker = ImagePicker();
  SchoolRegModel schoolRegModel = SchoolRegModel();
  TextEditingController textFieldController = TextEditingController();
  TextEditingController pastMatriculationfield = TextEditingController();
  TextEditingController std1 = TextEditingController();
  TextEditingController std2 = TextEditingController();
  TextEditingController std3 = TextEditingController();
  ///////////////////////////////inmage picker from gallery ////////////////////////////////
  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFiles.add(File(pickedFile.path));
      imagePaths.add(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

//////////////////////////// uplaod image to fiebase storage ///////////////////////////////////
  Future<List<String>> uploadImagesToFirebase() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFiles.length; i++) {
        Reference ref = storage.ref().child('images/image$i.jpg');
        await ref.putFile(imageFiles[i]);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      print('Images uploaded successfully');
      return imageUrls;
    } catch (e) {
      print('Error uploading images: $e');
      return [];
    }
  }

  ///////////////////////////////////////// Reg school data//////////////////////////////////////
  final databaseServices = DatabaseServices();
  Future<void> regSchool(SchoolRegModel schoolRegModel) async {
    setState(ViewState.busy);
    schoolRegModel.pastMatriculationImages = await uploadImagesToFirebase();

    try {
      await databaseServices.registerSchool(schoolRegModel);
    } catch (e) {}
    setState(ViewState.busy);
    print("sucessfull added");
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  Future pickImageMatriculation() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pastMatriculationImages.add(File(pickedFile.path));
      pastMatriculationImagesPath.add(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  Future<List<String>> uploadMatriculation() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    List<String> imageUrls = [];

    try {
      for (int i = 0; i < imageFiles.length; i++) {
        Reference ref = storage.ref().child('images/image$i.jpg');
        await ref.putFile(imageFiles[i]);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      print('Images uploaded successfully');
      return imageUrls;
    } catch (e) {
      print('Error uploading images: $e');
      return [];
    }
  }

  final basicInfomationKey = GlobalKey<FormState>();
  final acadmickey = GlobalKey<FormState>();
  final facilitykey = GlobalKey<FormState>();
  final financialkey = GlobalKey<FormState>();
  final pastmatriculationkey = GlobalKey<FormState>();
  final availabilitykey = GlobalKey<FormState>();
}
