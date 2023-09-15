import 'package:busconnect/screens/main_screen.dart';
import 'package:busconnect/screens/qr_scanner_screen.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';

// Registration screen
class StudentRegistrationScreen extends StatefulWidget {
  @override
  _StudentRegistrationScreenState createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {

  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _busStopController = TextEditingController();
  final _semesterController = TextEditingController();
  final _cityController = TextEditingController();
  final _rollNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Registration'),
        shadowColor: Theme.of(context).shadowColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _busStopController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bus Stop',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _semesterController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Semester',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'City',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _rollNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Roll Number',
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(top: 50),
                child: FilledButton(
                  onPressed: () async {
                    _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                        context: context,
                        onCode: (code) {
                          setState(() {
                            this.code = code;
                          });

                          if (code != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MainScreen()),
                            );
                          }
                        });
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
