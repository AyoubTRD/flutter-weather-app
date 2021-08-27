import 'package:geolocator/geolocator.dart';

class Location {
  Location({this.cityName});

  double? latitude;
  double? longitude;
  String? cityName;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
