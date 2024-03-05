import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';

class Availability extends StatelessWidget {
  final headerText;
  const Availability({super.key, this.headerText});

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
                    label: const Text("Teachers Qualification ((Primary) *"),
                    // hintText: 'Principal Name',
                    // onChanged: (val) {
                    //   model.princpalProfileModel
                    //       .principalName = val;
                    // },
                    //  controller:
                    //     model.principalNameController,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter principal name';
                    //   }
                    //   return null;
                    // },
                  ),
                  const SizedBox(height: 20),
                  BorderTextField(
                    label: const Text("Teachers Qualification (High) *"),
                    // onChanged: (val) {
                    //   model.princpalProfileModel
                    //       .schoolName = val;
                    // },
                    // hintText: 'Uca +street no',
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
                ]),
          ),
        ),
      ),
    );
  }
}
