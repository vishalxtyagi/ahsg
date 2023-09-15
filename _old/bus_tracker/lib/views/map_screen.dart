import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bus_tracker/models/location_model.dart';

class MapScreen extends StatelessWidget {
  final LocationModel location;

  MapScreen({required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('user_location'),
            position: LatLng(location.latitude, location.longitude),
          ),
        },
      ),
    );
  }
}
