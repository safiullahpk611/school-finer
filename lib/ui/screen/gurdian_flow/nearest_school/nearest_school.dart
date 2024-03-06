import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/ui/screen/gurdian_flow/nearest_school/nearest_school_provider.dart';

import '../../../../core/enums/view_state.dart';

class NearestSchool extends StatelessWidget {
  final lat;
  final longititude;
  NearestSchool({super.key, this.lat, this.longititude});

  // Dummy list of schools
  final List<String> dummySchools = [
    'School A',
    'School B',
    'School C',
    'School D',
    'School E',
    // Add more schools as needed
  ];

  @override
  Widget build(BuildContext context) {
    // print("lat is >>>>>>>>>>>>>>  $lat");
    // print("long is >>>>>>>>>>>>>>  $longititude");
    return ChangeNotifierProvider(create: (context) {
      return NearestSchoolProvider(lat, longititude);
    }, child: Consumer<NearestSchoolProvider>(builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nearest Schools'),
        ),
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            color: primaryColor,
          ),
          inAsyncCall: model.state == ViewState.busy,
          child: ListView.builder(
            itemCount: dummySchools.length,
            itemBuilder: (BuildContext context, int index) {
              if (model.results.results!.isNotEmpty) {
                return ListTile(
                  title: Text(model.results.results![index].name.toString()),
                  // You can add more details to display in the list tile
                  // such as distance, address, etc.
                );
              } else {
                // Handle the case where the list is empty or index is out of range
                return Container();
              }
            },
          ),
        ),
      );
    }));
  }
}
