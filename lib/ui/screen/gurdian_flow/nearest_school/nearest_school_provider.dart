import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:school_finder/core/enums/view_state.dart';
import 'package:school_finder/core/model/base_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:school_finder/core/model/mosque_list.dart';

class NearestSchoolProvider extends BaseViewModal {
  NearestSchoolProvider(lat, long) {
    searchForMosques(lat, long);
  }
  MosqeList results = MosqeList();

  bool isLoading = false;

  searchForMosques(lat, lng) async {
    print("lat $lat  lon $lng");
    //  Position position = await Geolocator.getCurrentPosition();
    print("object");
    const String apiKey = 'AIzaSyCo6PHJNnwEzkhIV7BXUl-BeGkg5yM1k8c';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'location=$lat,$lng&radius=2000&type=schools&key=$apiKey';
    print("before uri");
    Uri uri = Uri.parse(
      url,
    );
    print("before response");
    if (lat != null && lng != null) {
      setState(ViewState.busy);
      final response = await http.get(uri);
      print("aftr response");
      final data = jsonDecode(response.body);
      print(">>>>>>>>>>>>>> $data");

      try {
        results = MosqeList.fromJson(data);

        int id = 1;

        results.results?.forEach((element) {
          print("printing mosques");
          print(element.name);

          id = id + 1;
          print("printing id");
          print(id);

          // markers.add(Marker(
          //   markerId: MarkerId('$id'),
          //   position: LatLng(element.geometry!.location!.lat!,
          //       element.geometry!.location!.lng!),
          //   infoWindow: InfoWindow(
          //     title: element.name.toString(),
          //   ),
          // ));

          //print("${element.name}");
        });

        isLoading = true;
      } catch (e) {
        print("exe$e");
      }
    }
    setState(ViewState.idle);
  }
}
