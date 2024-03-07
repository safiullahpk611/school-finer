import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';
import 'scholl_reg_provider.dart';

class FinincialInformaton extends StatelessWidget {
  final headerText;
  const FinincialInformaton({super.key, this.headerText});

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
          child: SingleChildScrollView(
            child: Form(
              key: model.financialkey,
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
                      label: const Text("Funds Criteria"),
                      hintText: ' (e.g., Zakat, Optional)',
                      onChanged: (val) {
                        model.schoolRegModel.fundsCriteria = val;
                      },
                      ontap: () {},
                    ),
                    const SizedBox(height: 20),
                    BorderTextField(
                      label: const Text("Scholarship (Optional)"),
                      onChanged: (val) {
                        model.schoolRegModel.scholarshipCriteria = val;
                      },
                      //   hintText: 'Sports, Art and Craft',
                      // controller:
                      //     model.schoolNameController,
                    ),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
