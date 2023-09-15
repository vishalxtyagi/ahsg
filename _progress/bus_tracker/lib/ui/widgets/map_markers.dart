import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:bus_tracker/data/models/bus.dart';

Marker collegeMarker() {
  return Marker(
    markerId: MarkerId('college'),
    position: LatLng(12.9716, 77.5946),
    infoWindow: InfoWindow(title: 'College'),
  );
}

Marker busMarker(BuildContext context, Bus bus) {
  return Marker(
    markerId: MarkerId(bus.id),
    position: LatLng(bus.lat, bus.lng),
    onTap: () => showBusInfo(context, bus),
  );
}

Marker stopMarker(LatLng position) {
  return Marker(
    markerId: MarkerId('stop'),
    position: position,
    infoWindow: InfoWindow(title: 'Stop'),
  );
}

Future<void> showBusInfo(BuildContext context, Bus bus) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(bus.routeNumber),
        content: Text('Bus ID: ${bus.id}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}