import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/school_reg/scholl_reg_provider.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';

class PastMatriculationResults extends StatelessWidget {
  final headerText;
  const PastMatriculationResults({super.key, this.headerText});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolRegProvider>(builder: (context, model, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        decoration: BoxDecoration(
            //color: Colors.red,

            color: const Color(0xffce805b).withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Form(
            //  key: model.formKey,
            child: SingleChildScrollView(
              child: Form(
                key: model.pastmatriculationkey,
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
                        height: 120,
                        child: ListView.builder(
                          itemCount: model.pastMatriculationImages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: Image.file(
                              File(
                                model.pastMatriculationImagesPath[index],
                              ),
                              height: 70,
                            ));
                          },
                        ),
                      ),
                      BorderTextField(
                        suffixIcon: const Icon(Icons.upload),
                        label: const Text("Marks sheet of Top 3 Students"),
                        readOnly: true,
                        ontap: () {
                          print("object");
                          if (model.pastMatriculationImagesPath.length <= 3) {
                            model.pickImageMatriculation();
                          }

                          if (model.pastMatriculationImagesPath.isEmpty) {
                            model.pastMatriculationfield.text =
                                'No image selected';
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        keyBoardType: TextInputType.number,
                        label: const Text("Marks of 1st Division *"),
                        onChanged: (val) {
                          model.schoolRegModel.std1 = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Marks of 1st Division';
                          }
                          return null;
                        },
                        //  hintText: 'Sports, Art and Craft',
                        controller: model.std1,
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        keyBoardType: TextInputType.number,
                        label: const Text("Marks of 2nd Division *"),
                        onChanged: (val) {
                          model.schoolRegModel.std2 = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Marks of 2nd Division';
                          }
                          return null;
                        },
                        //  hintText: 'Sports, Art and Craft',
                        controller: model.std2,
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        keyBoardType: TextInputType.number,
                        label: const Text("Marks of 3rd Division *"),
                        onChanged: (val) {
                          model.schoolRegModel.std3 = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Marks of 3rd Division';
                          }
                          return null;
                        },
                        //  hintText: 'Sports, Art and Craft',
                        controller: model.std3,
                      ),
                      const SizedBox(height: 20),
                      BorderTextField(
                        label: const Text("School Guzzart Code "),

                        // controller:
                        //     model.timeslot,
                        onChanged: (val) {
                          // model.schoolRegModel.schoolGuzzartCode = val;
                          // model.timeslot.text=val;
                        },
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
