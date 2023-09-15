import 'package:sqflite/sqflite.dart';

import 'package:bus_tracker/data/models/bus.dart';

class DatabaseService {

  static const busTable = 'buses';
  static const studentTable = 'students';

  Future<Database> openDB() async {
    return openDatabase(
        'bus_app.db',
        version: 1,
        onCreate: (db, version) {
          // Create bus and student tables
        }
    );
  }

  Future<List> getBuses() async {
    final db = await openDB();

    final maps = await db.query(busTable);

    return List.generate(maps.length, (i) {
      return Bus(
        id: maps[i]['id'].toString(),
        routeNumber: maps[i]['route_number'].toString(),
        lat: 0,
        lng: 0,
      );
    });
  }

}