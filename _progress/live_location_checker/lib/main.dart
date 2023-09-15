import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      title: 'Live Bus Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  // Map controllers and markers
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  // Firestore subscription
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = FirebaseFirestore.instance
        .collection('locations')
        .snapshots()
        .listen((snapshot) {
      _updateMarkers(snapshot);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _updateMarkers(QuerySnapshot snapshot) {
    // Clear existing markers
    setState(() {
      _markers.clear();
    });

    // Add new marker for each document
    for (var doc in snapshot.docs) {
      print(doc.data());
      log("${doc.data()}");
      _markers.add(Marker(
        markerId: MarkerId(doc.id),
        position: LatLng(
            doc['latitude'],
            doc['longitude']),
        infoWindow: InfoWindow(title: doc['bus_name']),
      ));
    }
  }

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
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: initialLocation, zoom: 17.15),
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        polygons: {
          Polygon(
              polygonId: PolygonId("1"),
              points: polygonPoints,
              strokeWidth: 2,
              fillColor: Color(0xFF006491).withOpacity(0.2)
          )
        },
        markers: _markers,
      ),
    );
  }
}
