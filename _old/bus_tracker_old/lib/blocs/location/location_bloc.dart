import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationData> {
  final Location location = Location();

  LocationBloc() : super(LocationData.fromMap({
        'latitude': 0.0,
        'longitude': 0.0,
      }));
      
  @override
  Stream<LocationData> mapEventToState(LocationEvent event) async* {
    if (event is RequestLocationEvent) {
      yield* _mapRequestLocationEventToState();
    } else if (event is TrackLocationEvent) {
      yield* _mapTrackLocationEventToState();
    }
  }

  Stream<LocationData> _mapRequestLocationEventToState() async* {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();
    yield locationData;
  }

  Stream<LocationData> _mapTrackLocationEventToState() async* {
    location.onLocationChanged.listen((LocationData currentLocation) {
      add(LocationUpdatedEvent(currentLocation));
    });
  }
}
