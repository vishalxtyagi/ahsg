import 'package:geolocator/geolocator.dart';
import '../models/bus.dart';
import '../models/student.dart';

class LocationRepository {

  Stream<List<Bus>> getBusLocations() async* {
    // Get bus locations from API or database

    yield [
      Bus(
        id: '1',
        routeNumber: 'A1',
        lat: 29.211,
        lng: 77.016,
      ),
      Bus(
        id: '2',
        routeNumber: 'A2',
        lat: 13.345,
        lng: 77.567,
      ),
    ];
  }

  Stream<List<Student>> getStudentLocations() async* {
    // Get student locations from API or database

    yield [
      Student(
        id: '1',
        name: 'John Doe',
        busRoute: 'A1',
      ),
      Student(
        id: '2',
        name: 'Jane Smith',
        busRoute: 'A2',
      ),
    ];
  }

}