import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';
import 'scholl_reg_provider.dart';

class BasicInformation extends StatelessWidget {
  final principalId;
  final headerText;
  const BasicInformation({super.key, this.headerText, this.principalId});

  @override
  Widget build(BuildContext context) {
    print("id of princapl in $principalId");
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "$headerText",
                      style: GoogleFonts.unbounded(
                          textStyle: const TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    BorderTextField(
                      label: const Text("School Name *"),
                      onChanged: (val) {
                        model.schoolRegModel.schoolName = val;
                      },

                      // controller:
                      //     model.schoolNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter school name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    BorderTextField(
                      label: const Text("School Address *"),

                      // controller:
                      //     model.schoolRegNoController,
                      onChanged: (val) {
                        model.schoolRegModel.schoolAddress = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter school school Address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    BorderTextField(
                      label: const Text("Religion Specificity  *"),

                      hintText: 'e.g., Christian, Islamic',
                      // controller:
                      //     model.principalCNICController,
                      onChanged: (val) {
                        model.schoolRegModel.religionSpecificity = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter religionSpecificity';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () {
                          model.schoolRegModel.princpalId = principalId;
                          model.regSchool(model.schoolRegModel);
                        },
                        child: const Text("save")),
                    const SizedBox(height: 20),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
