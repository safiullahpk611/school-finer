import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:school_finder/core/model/appuser.dart';
import 'package:school_finder/ui/screen/gurdian_flow/google_mao_controller.dart';

import '../../../core/locator.dart';
import '../../../core/services/auth_services.dart';
import 'nearest_school/nearest_school.dart';

class GoogleMapScreen extends StatefulWidget {
  final userID;
  const GoogleMapScreen({super.key, this.userID});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

const kGoogleApiKey = 'AIzaSyBk2DwzAdLpFvZG-h0iGZgNS6xi8GyrOMo';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  CameraPosition? initialCameraPosition;
  bool servicesEnabled = false;
  late Position position;
  LatLng? currentSelectedPosition;

  var currentUser = locator<AuthServices>();
  //late AppUser appUser = AppUser(appUserId: '', userEmail: '', firstName: '');
  Set<Marker> markersList = {};
  double? getLat, getLng = 0.0;
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  String serach = "Search";
  String placeName = "";
  TextEditingController con = TextEditingController(text: "");

  @override
  void initState() {
    getPosition();
    super.initState();
  }

  getPosition() async {
    position = await _determinePosition();
    currentSelectedPosition = LatLng(position.latitude, position.longitude);
    initialCameraPosition = CameraPosition(
      target: currentSelectedPosition!,
      zoom: 18,
    );
    markersList.add(
      Marker(
        markerId: const MarkerId("1"),
        position: currentSelectedPosition!,
      ),
    );
    setState(() {
      servicesEnabled = true;
    });
  }

  void _reset() {
    serach = "Search";
    placeName = "";
  }

  _getLocation() async {
    Position position = await _determinePosition();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));
    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(position.latitude, position.longitude),
      ),
    );

    setState(() {});
    // log("Location:: ${LatLng(position.latitude, position.longitude)}");
    // store value to global variables
    getLat = position.latitude;
    getLng = position.longitude;
    // log("ABB::: ${getLat} ${getLng}");
    currentSelectedPosition = LatLng(position.latitude, position.longitude);
    getAddressPlaceName();
    // log("MarkerstList:: ${markersList}");
  }

  getAddressPlaceName() async {
    if (getLat != null && getLng != null) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(getLat!, getLng!);
      if (placemarks.isNotEmpty) {
        var firstPlace = placemarks.first;
        // log("Place Name through coordinates:: ${firstPlace.subLocality}");
        placeName =
            "${placemarks.first.thoroughfare}, ${placemarks.first.subLocality!}, ${placemarks.first.locality}";
        // log("ABB: $placeName");
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();

  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled');
  //   }

  //   permission = await Geolocator.checkPermission();

  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();

  //     if (permission == LocationPermission.denied) {
  //       return Future.error("Location permission denied");
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied');
  //   }

  //   Position position = await Geolocator.getCurrentPosition();

  //   return position;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: !servicesEnabled
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: initialCameraPosition!,
                  markers: markersList,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  // myLocationButtonEnabled: true,
                  // myLocationEnabled: true,

                  // onCameraMove: (CameraPosition  newPosition) {
                  //   setState(() {
                  //      initialCameraPosition = newPosition.target;
                  //   });
                  // },
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                  onCameraMove: (position) {
                    // print("Current position ==> $position");
                    currentSelectedPosition = position.target;
                    // print(
                    //     "model.currentUserPosition ==> ${currentSelectedPosition}");

                    _updateMarketPosition(position.target);
                  },
                  onCameraIdle: () async {
                    convertPointsToAddress();
                  },
                ),
                SafeArea(
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 70.0,
                              spreadRadius: 10.0,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 8,
                          ),
                          child: GestureDetector(
                            onTap: _handlePressButton,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 40.0,
                                    spreadRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text(serach),
                              ),

                              // onSubmitted: (value) {
                              //   // Call the search method when the user submits the search query
                              //   _handlePressButton();
                              // },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      // bottom: locator<DeviceType>().isSmallDevice ? 42 : 55,
                      bottom: 45,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // height: 30.h,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.red),
                          child: isDecodingAddress
                              ? Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  // "${placemarks?.first.name ?? ""}, ${placemarks?.first.administrativeArea ?? ""}",
                                  placeName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        //   SvgPicture.asset(
                        //     'assets/icons/map-marker.svg',
                        //  //   color: PrimaryColor.withOpacity(0.7),
                        //     // color: Color.fromARGB(255, 68, 172, 172),
                        //     height: 50,
                        //     width: 100,
                        //   ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Spacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                YourController obj = YourController(
                                  placeName,
                                  currentSelectedPosition!,
                                );
                                print("address=    $placeName");
                                print('long  ${position.latitude}');
                                Get.off(NearestSchool(
                                  lat: position.latitude,
                                  longitude: position.longitude,
                                ));
                                // Get.back();
                              });
                            },
                            // backgroundColor: primaryColor,

                            child: const Text("Confirm"),
                            // icon: const Icon(Icons.location_history),
                          ),
                        ),
                      ),
                      // Spacer(),
                      GestureDetector(
                        // color: primaryColor,
                        // style: IconButton.styleFrom(
                        //   backgroundColor: primaryColor,
                        // ),
                        // backgroundColor: Colors.white,
                        onTap: () {
                          _reset();
                          _getLocation();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.location_searching,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      // floatingActionButton:  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        // onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "pk"),
          Component(Component.country, "usa")
        ]);
    con.addListener(() {
      context;
    });
    // log("DD:: ${homeScaffoldKey.currentState}");
    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("1"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
    // log("Searched Location: ${detail.result.addressComponents}");
    final locality = detail.result.addressComponents.firstWhere((s) {
      if (s.types.contains("locality")) {
        return true;
      }
      return false;
    });

    // after the seraching to the same to variable
    placeName = "${detail.result.name}, ${locality.longName}";
    // log("Find Locality City Name: ${locality.longName}");
    con = TextEditingController(text: detail.result.name);
    serach = "${detail.result.name}, ${locality.longName}";
    getLat = lat;
    getLng = lng;
    // log("Place get location: ${getLat} ${getLng}");
  }

  List<Placemark>? placemarks;
  bool isDecodingAddress = false;
  convertPointsToAddress() async {
    // setState(ViewState.busy);
    // userProblem.latitude = address.latitude;
    // userProblem.longitude = address.longitude;
    isDecodingAddress = true;
    print("currentSelectedPosition => $currentSelectedPosition");
    // notifyListeners();
    placemarks = await placemarkFromCoordinates(
      currentSelectedPosition!.latitude,
      currentSelectedPosition!.longitude,
    );

    placeName =
        "${placemarks!.first.thoroughfare}, ${placemarks!.first.subLocality!}, ${placemarks!.first.locality}";

    getLat = currentSelectedPosition!.latitude;
    getLng = currentSelectedPosition!.longitude;
    // log("picker corrdintates ${getLat} ${getLng}");

    // isMapAddressSelected = true;
    // setState(ViewState.idle);
    // placemarks.first.
    // log("ppppppppp:: ${placemarks!.first}");
    isDecodingAddress = false;
    // notifyListeners();
    setState(() {});
    // print(placemarks!.first);
  }

  _updateMarketPosition(LatLng latlong) async {
    print("Inside updateMarketPosition");
    // print("\n\n\n\n$markers\n\n\n\n\n\n");
    // Marker marker = markers["a;
    markersList.clear();
    var x = markersList.add(
      Marker(
        markerId: const MarkerId("1"),
        position: latlong,
      ),
    );

    currentSelectedPosition = latlong;

    setState(() {});
  }
}
