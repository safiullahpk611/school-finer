import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';

class FacilitiesAndActivities extends StatelessWidget {
  final headerText;
  const FacilitiesAndActivities({super.key, this.headerText});

  @override
  Widget build(BuildContext context) {
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
                    label: const Text("Images of Marks Sheet *"),
                    hintText: 'Minimum three student data',
                    readOnly: true,
                    ontap: () {},
                  ),
                  const SizedBox(height: 20),
                  BorderTextField(
                    label: const Text("Marks (Number form)"),
                    // onChanged: (val) {
                    //   model.princpalProfileModel
                    //       .schoolName = val;
                    // },
                    //   hintText: 'Sports, Art and Craft',
                    // controller:
                    //     model.schoolNameController,
                  ),
                  const SizedBox(height: 20),
                  BorderTextField(
                    label: const Text("Guzzart Number (*)"),

                    // controller:
                    //     model.schoolRegNoController,
                    // onChanged: (val) {
                    //   model.princpalProfileModel
                    //       .schoolRegNo = val;
                    // },
                  ),
                  const SizedBox(height: 20),
                ]),
          ),
        ),
      ),
    );
  }
}
