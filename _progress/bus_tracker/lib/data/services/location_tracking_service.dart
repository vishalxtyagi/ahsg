import 'package:geolocator/geolocator.dart';

class LocationTrackingService {

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }

  Stream<Position> getLiveLocationUpdates() {
    return Geolocator.getPositionStream();
  }

}