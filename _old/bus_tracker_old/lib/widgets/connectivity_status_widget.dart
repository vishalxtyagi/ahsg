import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bus_tracker/blocs/network/network_bloc.dart';

class ConnectivityStatusWidget extends StatelessWidget {
  const ConnectivityStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkDisconnected) {
          return Text('Disconnected from the Internet');
        } else if (state is NetworkConnected) {
          return Text('Connected to the Internet via ${state.type}');
        } else {
          return const Text('Checking Internet Connection...');
        }
      },
    );
  }
}
