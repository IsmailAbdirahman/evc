import 'package:evcapp/models/store_info_model.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';

class StoresLocation {
  var storeInfo = Hive.box<StoreModel>(STORE_INFO);
  static List<StoreModel> storeNumbersList = [];

  Future checkLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      getCurrentStoreLocation();
    }
  }

  Future<Position> getCurrentStoreLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  addCurrentLocationToDatabase({double? lati, double? longi, String? phoneNO}) {
    storeInfo
        .add(
            StoreModel(mobileNumber: phoneNO, latitude: lati, longitude: longi))
        .whenComplete(() => print("SAVED TO DATABASE"));
  }

  List<StoreModel>? getAllLocationsFromDatabase() {
    storeNumbersList = storeInfo.toMap().values.toList();
    return storeNumbersList;
  }

  double calculateDistanceBetweenLocations(
      {double? savedLati,
      double? savedLongi,
      double? currentLati,
      double? currentLongi}) {
    double diff = Geolocator.distanceBetween(
        savedLati!, savedLongi!, currentLati!, currentLongi!);
    return diff;
  }
}
