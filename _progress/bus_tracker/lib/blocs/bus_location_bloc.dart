import 'package:bloc/bloc.dart';
import 'package:bus_tracker/data/models/bus.dart';
import 'package:bus_tracker/data/repositories/location_repository.dart';

class BusLocationBloc extends Bloc<BusLocationEvent, BusLocationState> {

  final LocationRepository _repo;

  BusLocationBloc(this._repo) : super(BusLocationState()) {
    on<StartTracking>(_onStartTracking);
  }

  void _onStartTracking(event, emit) {
    _repo.getBusLocations().listen((locations) {
      emit(state.copyWith(buses: locations));
    });
  }

}

// Events
abstract class BusLocationEvent {}

class StartTracking extends BusLocationEvent {}

// States
class BusLocationState {
  List<Bus> buses;

  BusLocationState({this.buses = const []});

  BusLocationState copyWith({List<Bus>? buses}) {
    return BusLocationState(
      buses: buses ?? this.buses,
    );
  }
}