import 'package:flutter/material.dart';

// Profile screen
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User profile info
  String userName = 'John Doe';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(userName),
        TextFormField(
          // Allow editing user info
        ),
        ElevatedButton(
          onPressed: () {
            // Save profile changes
          },
          child: Text('Update Profile'),
        )
      ],
    );
  }
}