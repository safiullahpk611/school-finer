import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../../../../core/color.dart';
import '../../../../../core/enums/view_state.dart';
import '../../../authentication/selection/selection_screen.dart';
import '../../../authentication/signup/sign_up.dart';
import '../../../authentication/signup/sign_up_provider.dart';
import 'scholl_reg_provider.dart';

class Availability extends StatefulWidget {
  final headerText;
  final princpalId;
  const Availability({super.key, this.headerText, this.princpalId});

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List<String> timeSlots = [
    "9:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 1:00 PM",
    "1:00 PM - 2:00 PM",
    "2:00 PM - 3:00 PM",
    "3:00 PM - 4:00 PM",
    "4:00 PM - 5:00 PM",
    "5:00 PM - 6:00 PM"
  ];
  Map<String, List<String>> availabilityData = {
    'Monday': [],
    'Tuesday': [],
    'Wednesday': [],
    'Thursday': [],
    'Friday': [],
  };
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String selectedDay = "Monday";
  List<bool> isSelected = List.generate(9, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Consumer<SchoolRegProvider>(builder: (context, model, child) {
      return ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: primaryColor,
        ),
        inAsyncCall: model.state == ViewState.busy,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
          decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: model.availabilitykey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.headerText}",
                        style: const TextStyle(fontSize: 22),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      // DropdownButtonFormField<String>(
                      //   value: model.setTimeSlot,
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       model.setTimeSlot = newValue!;
                      //     });
                      //   },
                      //   items: <String>[
                      //     '04/5/2024 on 10:50 am', // Add a default value or prompt
                      //     '03/5/2024 on 03:50 pm',
                      //     '06/5/2024 on 05:50 pm',
                      //   ].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      SizedBox(
                        height: 300,
                        child: ListView(
                          children: availabilityData.keys.map((day) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    day,
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Column(
                                    children:
                                        availabilityData[day]!.map((timeSlot) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0),
                                        child: Text(timeSlot),
                                      );
                                    }).toList(),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _addTimeSlot(day);
                                    },
                                    child: const Text('Add Time Slot'),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        title: 'Reg School Now',
                        onTap: () {
                          print("pricpal id is ${widget.princpalId}");
                          model.schoolRegModel.princpalId =
                              widget.princpalId.toString();

                          model.schoolRegModel.availableTimeSlot =
                              model.setTimeSlot.toString();
                          model.regSchool(model.schoolRegModel, context);
                          _updateFirestoreData();
                        },
                      )
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _addTimeSlot(String day) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController timeSlotController = TextEditingController();
        return AlertDialog(
          title: const Text('Add Time Slot'),
          content: TextField(
            controller: timeSlotController,
            decoration: const InputDecoration(
                labelText: 'Time Slot (e.g. 9:00 - 11:00 AM)'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  availabilityData[day]!.add(timeSlotController.text);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _updateFirestoreData() async {
    try {
      await firestore
          .collection('availability')
          .doc('principal')
          .set(availabilityData);
      print('Data saved to Firestore');
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
