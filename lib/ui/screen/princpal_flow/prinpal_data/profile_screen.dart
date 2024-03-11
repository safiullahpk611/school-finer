import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/ui/screen/authentication/selection/selection_screen.dart';
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
        return ProfileProvider(
          principalId,
        );
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
                          child: Column(
                            children: [
                              model.princpalProfileModel.appUserId == null
                                  ? const SizedBox(
                                      height: 100,
                                    )
                                  : const SizedBox(
                                      height: 10,
                                    ),
                              model.princpalProfileModel.appUserId == null
                                  ? Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 40),
                                      decoration: BoxDecoration(
                                          color: secondaryColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Form(
                                        key: model.formKey,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Princpal Profile Detail",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              BorderTextField(
                                                hintText: 'Principal Name',
                                                onChanged: (val) {
                                                  model.princpalProfileModel
                                                      .principalName = val;
                                                },
                                                controller: model
                                                    .principalNameController,
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
                                                hintText:
                                                    'School Registration No',
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
                                                label: const Text(
                                                    'Principal CNIC'),
                                                hintText:
                                                    ' CNIC (without dashes)',
                                                controller: model
                                                    .principalCNICController,
                                                onChanged: (val) {
                                                  model.princpalProfileModel
                                                      .cnic = val;
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Please enter principal CNIC';
                                                  }
                                                  return null;
                                                },
                                                inputParameter: [
                                                  LengthLimitingTextInputFormatter(
                                                      13),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyBoardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                        signed: true,
                                                        decimal: false),
                                              ),
                                              const SizedBox(height: 20),
                                              // TextFormField(
                                              //   onChanged: (val) {
                                              //     model.princpalProfileModel
                                              //         .cnic = val;
                                              //   },
                                              //   validator: (value) {
                                              //     if (value!.isEmpty) {
                                              //       return 'Please enter principal CNIC';
                                              //     }
                                              //     return null;
                                              //   },
                                              //   decoration:
                                              //       const InputDecoration(
                                              //     labelText:
                                              //         'Enter CNIC (without dashes)',
                                              //   ),
                                              //   keyboardType:
                                              //       const TextInputType
                                              //           .numberWithOptions(
                                              //           signed: true,
                                              //           decimal: false),
                                              //   inputFormatters: [
                                              //     LengthLimitingTextInputFormatter(
                                              //         13),
                                              //     FilteringTextInputFormatter
                                              //         .digitsOnly
                                              //   ],
                                              // ),

                                              IntlPhoneField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: (value) {
                                                  if (value?.completeNumber ==
                                                      null) {
                                                    return "Please enter your phone number";
                                                  }
                                                  return null;
                                                },
                                                flagsButtonPadding:
                                                    const EdgeInsets.all(8),
                                                dropdownIconPosition:
                                                    IconPosition.trailing,
                                                decoration: InputDecoration(
                                                  hintText: "Phone number",
                                                  hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0)),
                                                    borderSide: BorderSide(
                                                        width: 2,
                                                        color: Colors.black),
                                                  ),
                                                  // enabledBorder:
                                                  //     OutlineInputBorder(
                                                  //         borderRadius:
                                                  //             BorderRadius
                                                  //                 .circular(20),
                                                  //         borderSide:
                                                  //             BorderSide(
                                                  //                 color:
                                                  //                     logoColor,
                                                  //                 width: 1)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          borderSide: BorderSide(
                                                              color:
                                                                  primaryColor,
                                                              width: 2)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      14)),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 4),
                                                ),
                                                initialCountryCode: 'PK',
                                                onChanged: (phone) {
                                                  String countryCode = phone
                                                          .countryCode ??
                                                      ''; // Extract country code
                                                  String phoneNumber = phone
                                                          .number ??
                                                      ''; // Extract phone number
                                                  String fullPhoneNumber =
                                                      countryCode + phoneNumber;

                                                  print(fullPhoneNumber);
                                                  model.princpalProfileModel
                                                          .phoneNumber =
                                                      fullPhoneNumber;
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              // BorderTextField(
                                              //   hintText: 'Phone Number',
                                              //   controller:
                                              //       model.phoneNumberController,
                                              //   onChanged: (val) {
                                              //     model.princpalProfileModel
                                              //         .phoneNumber = val;
                                              //   },
                                              //   validator: (value) {
                                              //     if (value!.isEmpty) {
                                              //       return 'Please enter phone number';
                                              //     }
                                              //     return null;
                                              //   },
                                              // ),
                                              // const SizedBox(
                                              //   height: 20,
                                              // ),
                                              CustomButton(
                                                  onTap: () {
                                                    model.storePrincpalProfileData(
                                                        model
                                                            .princpalProfileModel,
                                                        context);
                                                  },
                                                  title: "Add Profile")
                                            ]),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Principal Name',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  model.princpalProfileModel
                                                          .principalName ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                          // subtitle: Text(
                                          //     model.princpalProfileModel
                                          //             .principalName ??
                                          //         '',
                                          //     style: const TextStyle(
                                          //         color: Colors.white)),
                                        ),
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('CNIC',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  model.princpalProfileModel
                                                          .cnic ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('Phone Number',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  model.princpalProfileModel
                                                          .phoneNumber ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                          // subtitle:
                                        ),
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text('School Name',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  model.princpalProfileModel
                                                          .schoolName ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                        ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                  'School Registration No',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  model.princpalProfileModel
                                                          .schoolRegNo ??
                                                      '',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )

                              // Add more ListTiles for other data as needed
                            ],
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
