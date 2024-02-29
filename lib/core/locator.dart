import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:school_finder/core/services/auth_services.dart';

GetIt locator = GetIt.instance;
// GetIt deviceLocator = GetIt.instance;
setupLocator() {
  print("AuthServices calling");
  locator.registerSingleton(AuthServices());

  print("AuthServices registered");
}
