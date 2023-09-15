import 'package:bus_tracker/ui/screens/attendance_screen.dart';
import 'package:bus_tracker/ui/screens/map_screen.dart';
import 'package:bus_tracker/ui/screens/student_list_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Selected tab index
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack( // Body content
        index: _selectedIndex,
        children: [
          MapScreen(),
          StudentListScreen(),
          AttendanceScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar( // Bottom navbar
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Students'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Attendance'
            ),
          ]
      ),
    );

  }

}