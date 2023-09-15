import 'package:flutter/material.dart';
import 'package:bus_tracker/controllers/location_controller.dart';
import 'package:bus_tracker/controllers/connectivity_controller.dart';
import 'package:bus_tracker/views/map_screen.dart';
import 'package:bus_tracker/views/connectivity_screen.dart';
import 'package:bus_tracker/models/location_model.dart';


void main() => runApp(BusTrackingApp());

class BusTrackingApp extends StatefulWidget {
  @override
  _BusTrackingAppState createState() => _BusTrackingAppState();
}

class _BusTrackingAppState extends State<BusTrackingApp> {
  LocationModel? currentLocation;
  bool isConnected = false;
  String connectionType = '';

  final LocationController locationController = LocationController();
  final ConnectivityController connectivityController =
      ConnectivityController();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    final location = await locationController.getCurrentLocation();
    final connected = await connectivityController.checkConnectivity();
    final connection = await connectivityController.getConnectionType();

    setState(() {
      currentLocation = location;
      isConnected = connected;
      connectionType = connection;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentLocation == null) {
      return MaterialApp(
        title: 'BusTracker+',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return MaterialApp(
        home: isConnected
            ? MapScreen(location: currentLocation!)
            : ConnectivityScreen(
                isConnected: isConnected,
                connectionType: connectionType,
              ),
      );
    }
  }
}
