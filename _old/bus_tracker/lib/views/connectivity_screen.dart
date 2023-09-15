import 'package:flutter/material.dart';

class ConnectivityScreen extends StatelessWidget {
  final bool isConnected;
  final String connectionType;

  ConnectivityScreen({required this.isConnected, required this.connectionType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connectivity Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connected: $isConnected'),
            SizedBox(height: 16),
            Text('Connection Type: $connectionType'),
          ],
        ),
      ),
    );
  }
}
