import 'package:bus_tracker/blocs/student_location_bloc.dart';
import 'package:bus_tracker/ui/widgets/common_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

import '../widgets/student_list_tile.dart';

class StudentListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<StudentLocationBloc, StudentLocationState>(
        builder: (context, state) {
          log("State: ${state.students}");
          return Scaffold(
            appBar: Common.appBar("Students"),
            body: ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, index) {
                  return StudentListItem(student: state.students[index]);
                }
            ),
          );
        }
    );

  }

}