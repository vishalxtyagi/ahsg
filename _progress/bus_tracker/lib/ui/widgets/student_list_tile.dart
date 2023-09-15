import 'package:flutter/material.dart';

import 'package:bus_tracker/data/models/student.dart';

class StudentListItem extends StatelessWidget {

  final Student student;

  const StudentListItem({required this.student});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      subtitle: Text(student.busRoute),
      trailing: Icon(student.isPresent ? Icons.check : Icons.close),
    );
  }

}