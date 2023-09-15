import 'package:bus_tracker/blocs/attendance_bloc.dart';
import 'package:bus_tracker/ui/widgets/common_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/attendance_card.dart';

class AttendanceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
          return Scaffold(
            appBar: Common.appBar("Attendance"),
            body: ListView.builder(
                itemCount: state.records.length,
                itemBuilder: (context, index) {
                  return AttendanceCard(record: state.records[index]);
                }
            ),
          );
        }
    );

  }

}