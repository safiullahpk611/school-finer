import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_finder/core/color.dart';
import 'package:school_finder/ui/screen/gurdian_flow/nearest_school/nearest_school_provider.dart';

import '../../../../core/enums/view_state.dart';

class NearestSchool extends StatelessWidget {
  final double lat;
  final double longitude;
  const NearestSchool({Key? key, required this.lat, required this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NearestSchoolProvider(lat, longitude),
      child: Consumer<NearestSchoolProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: logoColor,
              title: const Text('Nearest Schools'),
            ),
            body: ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(
                color: primaryColor,
              ),
              inAsyncCall: model.state == ViewState.busy,
              child: model.results.results != null
                  ? ListView.builder(
                      itemCount: model.results.results?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var school = model.results.results![index];
                        return ListTile(
                          title: Text(school.name.toString()),
                          leading: Image.network(school.icon.toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address: ${school.vicinity}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              FutureBuilder(
                                future: _calculateDistance(
                                  lat,
                                  longitude,
                                  school.geometry?.location?.lat ?? 0.0,
                                  school.geometry?.location?.lng ?? 0.0,
                                ),
                                builder: (BuildContext context,
                                    AsyncSnapshot<double> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text(
                                        'Calculating distance...');
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Text(
                                      'Distance: ${snapshot.data?.toStringAsFixed(2) ?? "N/A"} km',
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Future<double> _calculateDistance(
      double startLat, double startLng, double? endLat, double? endLng) async {
    // Calculate distance in meters
    double distanceInMeters = Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat!,
      endLng!,
    );

    // Convert meters to kilometers
    double distanceInKilometers = distanceInMeters / 1000.0;

    // Return the distance in kilometers
    return distanceInKilometers;
  }
}
