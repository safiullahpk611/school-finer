import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/school_reg/scholl_reg_provider.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';

class AcademicInformation extends StatelessWidget {
  final headerText;
  const AcademicInformation({super.key, this.headerText});

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
                      BorderTextField(
                        label:
                            const Text("Teachers Qualification ((Primary) *"),
                        // hintText: 'Principal Name',
                        onChanged: (val) {
                          model.schoolRegModel.teacherQualificationPrimary =
                              val;
                        },
                        //  controller:
                        //     model.principalNameController,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please enter principal name';
                        //   }}
                        //   return null;
                        // },
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        label: const Text("Teachers Qualification (High) *"),

                        onChanged: (val) {
                          model.schoolRegModel.teacherQualificationHigh = val;
                        },
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
                      BorderTextField(
                        label: const Text(
                            "Quran and Hifz Availability (Optional)"),
                        onChanged: (val) {
                          model.schoolRegModel.quranAndHifzAvailability = val;
                        },
                        // hintText: 'Uca +strqueet no',
                        // controller:
                        //     model.schoolNameController,
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        label:
                            const Text("Thermal Facility (Optiona (Optional)"),
                        onChanged: (val) {
                          model.schoolRegModel.thermalFacility = val;
                        },
                        // hintText: 'Uca +street no',
                        // controller:
                        //     model.schoolNameController,
                      ),
                      const SizedBox(height: 20),
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}
