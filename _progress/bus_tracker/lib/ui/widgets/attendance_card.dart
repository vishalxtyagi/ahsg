import 'package:flutter/material.dart';

import 'package:bus_tracker/data/models/attendance.dart';

class AttendanceCard extends StatelessWidget {

  final AttendanceRecord record;

  const AttendanceCard({required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student: ${record.studentName}',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text('Status: ${record.status}'),
          ],
        ),
      ),
    );
  }

}