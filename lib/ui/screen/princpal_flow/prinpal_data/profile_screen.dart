import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/profile_provider.dart';

import '../../../../core/enums/view_state.dart';
import '../../../../core/model/princpal_profile_mode.dart';
import '../../authentication/signup/sign_up.dart';
import 'store_princpal_data.dart';

class PrincipalProfile extends StatelessWidget {
  final String? principalId;

  const PrincipalProfile({Key? key, this.principalId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myContext = context;
    return ChangeNotifierProvider(
      create: (context) {
        print("id in profile screen $principalId");
        return ProfileProvider(principalId);
      },
      child: Consumer<ProfileProvider>(
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: primaryColor,
              body: ModalProgressHUD(
                  progressIndicator: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                  inAsyncCall: model.state == ViewState.busy,
                  child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: model.princpalProfileModel.appUserId != null
                              ? Column(
                                  children: [
                                    // ListTile(
                                    //   title: const Text('App User ID'),
                                    //   subtitle: Text(profileModel.appUserId ?? ''),
                                    // ),
                                    ListTile(
                                      title: const Text('Principal Name'),
                                      subtitle: Text(model.princpalProfileModel
                                              .principalName ??
                                          ''),
                                    ),
                                    ListTile(
                                      title: const Text('CNIC'),
                                      subtitle: Text(
                                          model.princpalProfileModel.cnic ??
                                              ''),
                                    ),
                                    ListTile(
                                      title: const Text('Phone Number'),
                                      subtitle: Text(model.princpalProfileModel
                                              .phoneNumber ??
                                          ''),
                                    ),

                                    ListTile(
                                      title: const Text('School Name'),
                                      subtitle: Text(model.princpalProfileModel
                                              .schoolName ??
                                          ''),
                                    ),
                                    ListTile(
                                      title:
                                          const Text('School Registration No'),
                                      subtitle: Text(model.princpalProfileModel
                                              .schoolRegNo ??
                                          ''),
                                    ),
                                    // Add more ListTiles for other data as needed
                                  ],
                                )
                              : Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 40),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffce805b)
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Form(
                                    key: model.formKey,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          BorderTextField(
                                            hintText: 'Principal Name',
                                            onChanged: (val) {
                                              model.princpalProfileModel
                                                  .principalName = val;
                                            },
                                            controller:
                                                model.principalNameController,
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
                                              model.princpalProfileModel
                                                  .schoolName = val;
                                            },
                                            hintText: 'School Name',
                                            controller:
                                                model.schoolNameController,
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
                                            controller:
                                                model.schoolRegNoController,
                                            onChanged: (val) {
                                              model.princpalProfileModel
                                                  .schoolRegNo = val;
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
                                            controller:
                                                model.principalCNICController,
                                            onChanged: (val) {
                                              model.princpalProfileModel.cnic =
                                                  val;
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
                                            controller:
                                                model.phoneNumberController,
                                            onChanged: (val) {
                                              model.princpalProfileModel
                                                  .phoneNumber = val;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter phone number';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (model.formKey.currentState!
                                                  .validate()) {
                                                // Do something with the collected data
                                                // For example, print to console
                                                // print('Principal Name: ${_principalNameController.text}');
                                                // print('School Name: ${_schoolNameController.text}');
                                                // print('School Registration No: ${_schoolRegNoController.text}');
                                                // print('Principal CNIC: ${_principalCNICController.text}');
                                                // print('Phone Number: ${_phoneNumberController.text}');
                                                print(
                                                    "princpal id is $principalId");
                                                model.princpalProfileModel
                                                    .appUserId = principalId;
                                                model.storePrincpalProfileData(
                                                    model.princpalProfileModel,
                                                    context);
                                              }
                                            },
                                            child: const Text('Save'),
                                          ),
                                        ]),
                                  ),
                                )))));
        },
      ),
    );
  }
}

class ProfileDataView extends StatelessWidget {
  final PrincpalProfileModel profileModel;

  const ProfileDataView(this.profileModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // ListTile(
          //   title: const Text('App User ID'),
          //   subtitle: Text(profileModel.appUserId ?? ''),
          // ),
          ListTile(
            title: const Text('Principal Name'),
            subtitle: Text(profileModel.principalName ?? ''),
          ),
          ListTile(
            title: const Text('CNIC'),
            subtitle: Text(profileModel.cnic ?? ''),
          ),
          ListTile(
            title: const Text('Phone Number'),
            subtitle: Text(profileModel.phoneNumber ?? ''),
          ),

          ListTile(
            title: const Text('School Name'),
            subtitle: Text(profileModel.schoolName ?? ''),
          ),
          ListTile(
            title: const Text('School Registration No'),
            subtitle: Text(profileModel.schoolRegNo ?? ''),
          ),

          // Add more ListTiles for other data as needed
        ],
      ),
    );
  }
}
