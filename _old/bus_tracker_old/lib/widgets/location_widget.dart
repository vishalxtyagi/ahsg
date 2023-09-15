import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker/blocs/location/location_bloc.dart';
import 'package:location/location.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationData>(
      builder: (context, locationData) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Latitude: ${locationData.latitude}'),
              Text('Longitude: ${locationData.longitude}'),
              ElevatedButton(
                onPressed: () {
                  context.read<LocationBloc>().add(RequestLocationEvent());
                },
                child: Text('Get Location'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<LocationBloc>().add(TrackLocationEvent());
                },
                child: Text('Track Location'),
              ),
            ],
          ),
        );
      },
    );
  }
}
