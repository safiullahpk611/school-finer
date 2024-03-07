import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';
import 'scholl_reg_provider.dart';

class FacilitiesAndActivities extends StatelessWidget {
  final princpalId;
  final headerText;
  const FacilitiesAndActivities({super.key, this.headerText, this.princpalId});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolRegProvider>(builder: (context, model, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        decoration: BoxDecoration(
            color: const Color(0xffce805b).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Form(
            //  key: model.formKey,
            child: SingleChildScrollView(
              child: Form(
                key: model.facilitykey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$headerText",
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: model.imagePaths.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: Image.file(
                              File(
                                model.imagePaths[index],
                              ),
                              height: 70,
                            ));
                          },
                        ),
                      ),
                      BorderTextField(
                        suffixIcon: const Icon(Icons.upload),
                        label: const Text("select Infrastructure images "),
                        readOnly: true,
                        ontap: () {
                          print("object");
                          model.pickImage();
                          if (model.imagePaths.isEmpty) {
                            model.textFieldController.text =
                                'No image selected';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        label: const Text("Doctor Facility (Optional)"),
                        onChanged: (val) {
                          model.schoolRegModel.doctorFacility = val;
                        },
                        // validator: (val){
                        //      if (val!.isEmpty) {
                        //       return 'Enter Doctor Facility (Optional)';
                        //     }
                        //     return null;

                        // },
                        //   hintText: 'Sports, Art and Craft',
                        // controller:
                        //     model.schoolNameController,
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        label: const Text("Transport Facility (Optional)"),

                        // controller:
                        //     model.schoolRegNoController,
                        onChanged: (val) {
                          model.schoolRegModel.transportFacility = val;
                        },
                      ),
                      //   const SizedBox(height: 20),
                      // TextButton(
                      //     onPressed: () {
                      //       model.schoolRegModel.princpalId = princpalId;
                      //       model.regSchool(model.schoolRegModel);
                      //     },
                      //     child: const Text("done"))
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
