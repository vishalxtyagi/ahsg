import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/bus_location_bloc.dart';
import '../widgets/map_markers.dart';
import '../widgets/common_components.dart';

class MapScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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

    return BlocBuilder<BusLocationBloc, BusLocationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: Common.appBar("BusTracker+"),
            body: GoogleMap(
              markers: state.buses.map((bus) => busMarker(context, bus)).toSet(),
              initialCameraPosition: CameraPosition(
                zoom: 17.15,
                target: initialLocation
              ),
              polygons: {
                Polygon(
                  polygonId: PolygonId("1"),
                  points: polygonPoints,
                  strokeWidth: 2,
                  fillColor: Color(0xFF006491).withOpacity(0.2)
                )
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.list),
              onPressed: () {
                Navigator.pushNamed(context, '/students');
              },
            ),
          );
        }
    );

  }

}