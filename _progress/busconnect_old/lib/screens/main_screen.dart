import 'package:busconnect/screens/dashboard/attendance_screen.dart';
import 'package:busconnect/screens/dashboard/notification_screen.dart';
import 'package:busconnect/screens/dashboard/profile_screen.dart';
import 'package:busconnect/screens/unavailable_screen.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

// Bottom navigation bar
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  static List<Widget> pages = <Widget>[
    UnavailableScreen(),
    AttendanceScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.directions_bus),
            label: 'Track Bus',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Updates',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
