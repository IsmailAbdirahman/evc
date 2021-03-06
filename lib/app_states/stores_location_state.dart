import 'package:evcapp/models/store_info_model.dart';
import 'package:evcapp/service/stores_location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storesLocationProvider =
    ChangeNotifierProvider<StoresLocationState>((ref) {
  return StoresLocationState();
});

final futureLocationProvider = FutureProvider.autoDispose<List<String>>((ref) {
  final data = ref.watch(storesLocationProvider);
  Future<List<String>> dd =
      ref.watch(storesLocationProvider).getClosestLocationPhoneNumber();
  return dd;
});

//--

class StoresLocationState extends ChangeNotifier {
  StoresLocation _storesLocation = StoresLocation();
  late double latitude;
  late double longitude;
  List<String> listOfClosestNumbers = [];
  bool isCurrentLocationAvailable = false;

  checkLocationPermission() async {
    await _storesLocation.checkLocationPermission();
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    await _storesLocation.getCurrentStoreLocation().then((currentLocation) {
      latitude = currentLocation.latitude;
      longitude = currentLocation.longitude;
    });
    notifyListeners();
  }

  addCurrentLocationToDatabase({double? lati, double? longi, String? phoneNO}) {
    _storesLocation.addCurrentLocationToDatabase(
        lati: lati, longi: longi, phoneNO: phoneNO);
  }

  List<StoreModel>? getAllLocationsFromDatabase() {
    notifyListeners();
    return _storesLocation.getAllLocationsFromDatabase();
  }

  Future<List<String>> getClosestLocationPhoneNumber() async {
    print("isCurrentLocationAvailableisCurrentLocationAvailableisCurrentLocationAvailable $isCurrentLocationAvailable");

    await getCurrentLocation();
    getAllLocationsFromDatabase()!.forEach((position) {
      double diff = calculateDistanceBetweenLocations(
          savedLati: position.latitude,
          savedLongi: position.longitude,
          currentLati: latitude,
          currentLongi: longitude);
      if (diff <= 1.1781551770767794) {
        if (!listOfClosestNumbers.contains(position.mobileNumber)) {
          isCurrentLocationAvailable = true;
          print("isCurrentLocationAvailableisCurrentLocationAvailableisCurrentLocationAvailable $isCurrentLocationAvailable");
          listOfClosestNumbers.add(position.mobileNumber!);
        }
      }
    });

    return listOfClosestNumbers;
  }

  double calculateDistanceBetweenLocations(
      {double? savedLati,
      double? savedLongi,
      double? currentLati,
      double? currentLongi}) {
    double diff = _storesLocation.calculateDistanceBetweenLocations(
        savedLati: savedLati,
        savedLongi: savedLongi,
        currentLati: currentLati,
        currentLongi: currentLongi);
    return diff;
  }
}
