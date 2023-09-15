import 'package:geolocator/geolocator.dart';
import 'package:bus_tracker/models/location_model.dart';

class LocationController {
  Future<LocationModel> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return LocationModel(latitude: position.latitude, longitude: position.longitude);
  }
}