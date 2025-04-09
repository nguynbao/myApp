import 'package:flutter/material.dart';
import 'package:my_first_app/page/my_app.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied.');
  }

  // ✅ Quan trọng: Đặt độ chính xác cao nhất
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Position positionCurrent = await _determinePosition();

  print(
    "Latitude: ${positionCurrent.latitude}, Longitude: ${positionCurrent.longitude}",
  );
  runApp(MyApp(positionCurrent: positionCurrent));
}
