import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker/blocs/location/location_bloc.dart';
import 'package:bus_tracker/widgets/location_widget.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracking'),
      ),
      body: BlocProvider(
        create: (context) => LocationBloc()..add(RequestLocationEvent()),
        child: LocationWidget(),
      ),
    );
  }
}