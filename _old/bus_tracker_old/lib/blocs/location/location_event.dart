part of 'location_bloc.dart';

abstract class LocationEvent {}

class RequestLocationEvent extends LocationEvent {}

class TrackLocationEvent extends LocationEvent {}

class LocationUpdatedEvent extends LocationEvent {
  final LocationData locationData;

  LocationUpdatedEvent(this.locationData);
}