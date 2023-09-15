import 'package:flutter/material.dart';
import 'package:bus_tracker/widgets/connectivity_status_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BusTracker+'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConnectivityStatusWidget(),
          ],
        ),
      ),
    );
  }
}
