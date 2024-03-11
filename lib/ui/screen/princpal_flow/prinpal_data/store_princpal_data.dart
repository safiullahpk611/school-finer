import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/core/configs/app_typography_ext.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/profile_provider.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/profile_screen.dart';

import '../../../../core/model/princpal_profile_mode.dart';
import '../../authentication/signup/sign_up.dart';
import 'school_reg/school_reg.dart';
import 'store_princpal_data_provider.dart';

class PrincipalData extends StatefulWidget {
  final princpalId;
  const PrincipalData({super.key, this.princpalId});

  @override
  State<PrincipalData> createState() => _PrincipalDataState();
}

class _PrincipalDataState extends State<PrincipalData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myContext = context;
    return ChangeNotifierProvider(
      create: (context) {
        return StorePrincpalDataProvider(widget.princpalId);
      },
      child: Consumer<StorePrincpalDataProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: primaryColor,
            key: model.scaffoldKey,
            appBar: AppBar(
              backgroundColor: logoColor,
              title: Text('Principal Profile',
                  style: const TextStyle().s(20).cl(primaryColor).w(6)),
            ),
            body: _buildBody(model),
            bottomNavigationBar: SalomonBottomBar(
              backgroundColor: logoColor,
              currentIndex: model.currentIndex,
              onTap: (i) => setState(() => model.currentIndex = i),
              items: [
                SalomonBottomBarItem(
                    icon: const Icon(Icons.home),
                    title: const Text("Home"),
                    selectedColor: primaryColor),
                SalomonBottomBarItem(
                    icon: const Icon(Icons.school_rounded),
                    title: const Text("Add School"),
                    selectedColor: primaryColor),
                SalomonBottomBarItem(
                    icon: const Icon(Icons.chat),
                    title: const Text("Chat"),
                    selectedColor: primaryColor),
                SalomonBottomBarItem(
                    icon: const Icon(Icons.person),
                    title: const Text("Profile"),
                    selectedColor: primaryColor),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    StorePrincpalDataProvider model,
  ) {
    switch (model.currentIndex) {
      case 0:
        return const Center(child: Text("Comming soon"));
      case 1:
        return SchoolRegScreen(
          principalId: widget.princpalId,
        );
      case 2:
        return const Center(child: Text("Comming soon"));

      case 3:
        return PrincipalProfile(
          principalId: widget.princpalId,
        );

      default:
        return Container(); // Handle invalid index
    }
  }

  @override
  dispose() {
    super.dispose();
  }
}

class PrincipalDialog extends StatefulWidget {
  PrincpalProfileModel princpalProfileModel = PrincpalProfileModel();
  ProfileProvider storeProModel;
  BuildContext context;
  final principalId;
  PrincipalDialog(
      {super.key,
      required this.princpalProfileModel,
      required this.storeProModel,
      this.principalId,
      required this.context});

  @override
  _PrincipalDialogState createState() => _PrincipalDialogState();
}

class _PrincipalDialogState extends State<PrincipalDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _principalNameController =
      TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _schoolRegNoController = TextEditingController();
  final TextEditingController _principalCNICController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(' Principal Data'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BorderTextField(
              hintText: 'Principal Name',
              onChanged: (val) {
                widget.princpalProfileModel.principalName = val;
              },
              controller: _principalNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter principal name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BorderTextField(
              onChanged: (val) {
                widget.princpalProfileModel.schoolName = val;
              },
              hintText: 'School Name',
              controller: _schoolNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter school name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BorderTextField(
              hintText: 'School Registration No',
              controller: _schoolRegNoController,
              onChanged: (val) {
                widget.princpalProfileModel.schoolRegNo = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter school registration number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BorderTextField(
              hintText: 'Principal CNIC',
              controller: _principalCNICController,
              onChanged: (val) {
                widget.princpalProfileModel.cnic = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter principal CNIC';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            BorderTextField(
              hintText: 'Phone Number',
              controller: _phoneNumberController,
              onChanged: (val) {
                widget.princpalProfileModel.phoneNumber = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter phone number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Do something with the collected data
              // For example, print to console
              // print('Principal Name: ${_principalNameController.text}');
              // print('School Name: ${_schoolNameController.text}');
              // print('School Registration No: ${_schoolRegNoController.text}');
              // print('Principal CNIC: ${_principalCNICController.text}');
              // print('Phone Number: ${_phoneNumberController.text}');
              widget.storeProModel.princpalProfileModel.appUserId =
                  widget.principalId;
              widget.storeProModel.storePrincpalProfileData(
                  widget.storeProModel.princpalProfileModel, widget.context);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _principalNameController.dispose();
    _schoolNameController.dispose();
    _schoolRegNoController.dispose();
    _principalCNICController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
