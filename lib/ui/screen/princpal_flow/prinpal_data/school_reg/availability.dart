import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../core/color.dart';
import '../../../authentication/signup/sign_up.dart';
import '../../../authentication/signup/sign_up_provider.dart';
import 'scholl_reg_provider.dart';

class Availability extends StatefulWidget {
  final headerText;
  const Availability({super.key, this.headerText});

  @override
  State<Availability> createState() => _AvailabilityState();
}

class _AvailabilityState extends State<Availability> {
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.headerText}",
                      style: GoogleFonts.unbounded(
                          textStyle: const TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownButtonFormField<String>(
                      value: model.setTimeSlot,
                      onChanged: (String? newValue) {
                        setState(() {
                          model.setTimeSlot = newValue!;
                        });
                      },
                      items: <String>[
                        '04/5/2024 on 10:50 am', // Add a default value or prompt
                        '03/5/2024 on 03:50 pm',
                        '06/5/2024 on 05:50 pm',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
