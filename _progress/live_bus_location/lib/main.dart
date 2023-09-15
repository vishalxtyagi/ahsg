import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'dart:developer';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;
  String _status = 'Stopped';
  late StreamSubscription<Position> _positionStream;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // var initializationSettingsAndroid =
    // new AndroidInitializationSettings('app_icon');
    // var initializationSettings = new InitializationSettings(
    //   android: initializationSettingsAndroid,
    // );
    // flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _requestPermissions();

    _getCurrentLocation();
  }

  _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      // Handle errors when fetching current location
      print('Error fetching current location: $e');
    }
  }

  Completer<GoogleMapController> _mapController = Completer();


  LatLng initialLocation = const LatLng(29.211103, 77.016694);

  List<LatLng> polygonPoints = [
    LatLng(29.211785111762627, 77.0180224314173),
    LatLng(29.21179213504338, 77.01736529023052),
    LatLng(29.211890460778594, 77.0173679724393),
    LatLng(29.211902166216987, 77.0166545048986),
    LatLng(29.21227205738114, 77.016662551525),
    LatLng(29.212316537874248, 77.01597858828109),
    LatLng(29.21072693350436, 77.01526243842025),
    LatLng(29.21036406013096, 77.01523025191464),
    LatLng(29.210380447988445, 77.01510150589226),
    LatLng(29.21034299002466, 77.01502372183707),
    LatLng(29.21028914417774, 77.0149754420787),
    LatLng(29.209827941620457, 77.01489497580822),
    LatLng(29.20957978101729, 77.01486278930261),
    LatLng(29.20930118490717, 77.01484401384101),
    LatLng(29.20927777343302, 77.0155092016507),
    LatLng(29.210321919907187, 77.01555479919878),
    LatLng(29.210310214293425, 77.01730896382325),
    LatLng(29.210858035836708, 77.01733846819839),
    LatLng(29.21082526027191, 77.01850254681743),
    LatLng(29.211309869340326, 77.01852668669663),
    LatLng(29.2113285981599, 77.01802511365261)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _currentPosition != null
                  ? CameraPosition(
                  target: LatLng(_currentPosition!.latitude,
                      _currentPosition!.longitude))
                  : CameraPosition(target: initialLocation, zoom: 17.15),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
              polygons: {
                Polygon(
                    polygonId: PolygonId("1"),
                    points: polygonPoints,
                    strokeWidth: 2,
                    fillColor: Color(0xFF006491).withOpacity(0.2)
                )
              },
              markers: {
                if (_currentPosition != null)
                  Marker(
                    markerId: MarkerId('currentLocation'),
                    position: LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    ),
                  )
              },
            ),
          ),
          Text('Status: $_status'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                child: Icon(Icons.play_arrow),
                onPressed: _startTracking,
              ),
              FloatingActionButton(
                child: Icon(Icons.stop),
                onPressed: _stopTracking,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _requestPermissions() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle denied permission
        _showPermissionDeniedDialog(); // Show the dialog on permission denial
      }
    } catch (e) {
      // Handle errors when requesting permissions
      print('Error requesting permissions: $e');
    }
  }

  Future<void> _startTracking() async {
    try {
      setState(() {
        _status = 'Tracking';
      });

      // Start the foreground service
      FlutterForegroundTask.init(
        androidNotificationOptions: AndroidNotificationOptions(
          channelId: 'foreground_service',
          channelName: 'Location Tracking',
          channelDescription: 'Tracking location...',
          channelImportance: NotificationChannelImportance.HIGH,
          priority: NotificationPriority.LOW,
          iconData: const NotificationIconData(
            resType: ResourceType.mipmap,
            resPrefix: ResourcePrefix.ic,
            name: 'launcher',
          ),
        ),
        iosNotificationOptions: const IOSNotificationOptions(
          showNotification: true,
          playSound: false,
        ),
        foregroundTaskOptions: const ForegroundTaskOptions(
          interval: 5000,
          isOnceEvent: false,
          autoRunOnBoot: true,
          allowWakeLock: true,
          allowWifiLock: true,
        ),
      );

      _positionStream = Geolocator.getPositionStream().listen((Position newPosition) async {
        setState(() {
          _currentPosition = newPosition;
        });

        // Get completed controller
        GoogleMapController controller = await _mapController.future;

        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(newPosition.latitude, newPosition.longitude),
            zoom: 20,
          ),
        ));

        // Save to Firebase
        String documentId = 'bus2302'; // Replace with the specific document ID you want to update

        await firestore.collection('locations').doc(documentId).set({
          'bus_name': documentId,
          'latitude': newPosition.latitude,
          'longitude': newPosition.longitude,
          'timestamp': Timestamp.now(),
        }, SetOptions(merge: true));
      });

    } catch (e) {
      // Handle errors when starting tracking
      print('Error starting tracking: $e');
    }
  }

  void _stopTracking() async {
    setState(() {
      _status = 'Stopped';
    });
    _positionStream.cancel();

    // Stop the foreground service
    await FlutterForegroundTask.stopService();

    // Remove notification
    // flutterLocalNotificationsPlugin.cancel(0);
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Denied'),
          content: Text('Location permission has been denied. Please grant the permission in settings to use this feature.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
