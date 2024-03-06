import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class YourController extends GetxController {
  static RxString addressValue = ''.obs;
  static RxDouble lat = 0.0.obs;
  static RxDouble lng = 0.0.obs;
  YourController(String initialValue, LatLng currentSelectedPosition) {
    addressValue.value = initialValue;
    lat.value = currentSelectedPosition.latitude;
    lng.value = currentSelectedPosition.longitude;
  }
}
