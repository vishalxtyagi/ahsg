import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/app_router.dart';
import 'blocs/attendance_bloc.dart';
import 'blocs/bus_location_bloc.dart';
import 'blocs/student_location_bloc.dart';
import 'data/repositories/attendance_repository.dart';
import 'data/repositories/location_repository.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    final attendanceRepository = AttendanceRepository();
    final locationRepository = LocationRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AttendanceBloc(attendanceRepository)..add(LoadAttendance())),
        BlocProvider(create: (context) => BusLocationBloc(locationRepository)..init()),
        BlocProvider(create: (context) => StudentLocationBloc(locationRepository)..add(LoadStudents())),
      ],
      child: MaterialApp(
        title: 'BusTracker+',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green,
            useMaterial3: true
        ),
        routes: AppRouter.routes,
        initialRoute: AppRouter.initialRoute
      ),
    );
  }
}