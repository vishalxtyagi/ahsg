import 'package:bus_tracker/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/map_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/student_list_screen.dart';

class AppRouter {

  // Routes
  static final routes = {
    '/': (context) => HomeScreen(),
    '/map': (context) => MapScreen(),
    '/students': (context) => StudentListScreen(),
    '/attendance': (context) => AttendanceScreen(),
  };

  // Initial route
  static const initialRoute = '/';

}