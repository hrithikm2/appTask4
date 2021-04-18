import 'package:app_task4/Services/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationChange with ChangeNotifier {
  final geolocatorService = GeolocatorService();

  LocationChange() {
    setCurrentLocation();
  }

  Position currentLocation;

  setCurrentLocation() async {
    currentLocation = await geolocatorService.getCurrentLocation();
    notifyListeners();
  }
}