import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/ui/screen/princpal_flow/prinpal_data/school_reg/past_matriculation_results.dart';

import '../../../../../core/color.dart';
import '../profile_provider.dart';
import 'Facilities_and_activities.dart';
import 'acedmic_information.dart';
import 'availability.dart';
import 'basic_information.dart';
import 'finincial_infiormation.dart';
import 'scholl_reg_provider.dart';

class SchoolRegScreen extends StatefulWidget {
  final principalId;
  const SchoolRegScreen({super.key, this.principalId});

  @override
  State<SchoolRegScreen> createState() => _SchoolRegScreenState();
}

class _SchoolRegScreenState extends State<SchoolRegScreen> {
  int activeStep = 0;
  // Initial step set to 5.
  int upperBound = 5;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        //   print("id in profile screen ${widget.principalId}");
        return ProfileProvider(
          widget.principalId,
        );
      },
      child: Consumer<ProfileProvider>(builder: (context, model, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: model.princpalProfileModel.appUserId != null
                  ? Column(
                      children: [
                        IconStepper(
                          scrollingDisabled: false,

                          enableNextPreviousButtons: false,
                          enableStepTapping: false,
                          icons: const [
                            Icon(Icons.supervised_user_circle),
                            Icon(Icons.school),
                            Icon(Icons.local_activity),
                            Icon(Icons.money),
                            Icon(Icons.track_changes),
                            Icon(Icons.calendar_month),
                          ],

                          // activeStep property set to activeStep variable defined above.
                          activeStep: activeStep,

                          // This ensures step-tapping updates the activeStep.
                          onStepReached: (index) {
                            setState(() {
                              activeStep = index;
                            });
                          },
                        ),
                        Expanded(
                            child: activeStep == 0
                                ? BasicInformation(
                                    headerText: 'Step 1: Basic Information',
                                    principalId: widget.principalId)
                                : activeStep == 1
                                    ? const AcademicInformation(
                                        headerText:
                                            "Step 2: Academic Information")
                                    : activeStep == 2
                                        ? FacilitiesAndActivities(
                                            headerText:
                                                "Step 3: Facilities And Activities",
                                            princpalId: widget.principalId,
                                          )
                                        : activeStep == 3
                                            ? const FinincialInformaton(
                                                headerText:
                                                    "STEP 4: Financial Information")
                                            : activeStep == 4
                                                ? const PastMatriculationResults(
                                                    headerText:
                                                        "Step 5: Past Matriculation Results")
                                                : activeStep == 5
                                                    ? Availability(
                                                        headerText:
                                                            "Step 6: Availability",
                                                        princpalId:
                                                            widget.principalId,
                                                      )
                                                    : Text("$activeStep")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            previousButton(),
                            Consumer<SchoolRegProvider>(
                                builder: (context, model, child) {
                              return nextButton(activeStep == 0
                                  ? model.basicInfomationKey
                                  : activeStep == 1
                                      ? model.acadmickey
                                      : activeStep == 2
                                          ? model.facilitykey
                                          : activeStep == 3
                                              ? model.financialkey
                                              : activeStep == 4
                                                  ? model.pastmatriculationkey
                                                  : activeStep == 5
                                                      ? model.availabilitykey
                                                      : null);
                            })
                          ],
                        ),
                      ],
                    )
                  : const Center(
                      child: Text("Enter Your Profile First"),
                    )),
        );
      }),
    );
  }

  /// Returns the next button.
  Widget nextButton(currentkey) {
    return Consumer<SchoolRegProvider>(builder: (context, model, child) {
      return ElevatedButton(
        onPressed: () {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.

          if (activeStep < upperBound && currentkey.currentState!.validate()) {
            setState(() {
              activeStep++;
            });
          }
          // if(activeStep)
        },
        child: const Text('Next'),
      );
    });
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        //    color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Preface';

      case 2:
        return 'Table of Contents';

      case 3:
        return 'About the Author';

      case 4:
        return 'Publisher Information';

      case 5:
        return 'Reviews';

      case 6:
        return 'Chapters #1';

      default:
        return 'Step 1: Basic Information';
    }
  }
}
