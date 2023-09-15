import 'package:busconnect/screens/main_screen.dart';
import 'package:busconnect/screens/qr_scanner_screen.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';

// Registration screen
class GuestRegistrationScreen extends StatefulWidget {
  @override
  _GuestRegistrationScreenState createState() => _GuestRegistrationScreenState();
}

class _GuestRegistrationScreenState extends State<GuestRegistrationScreen> {

  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  // Form key
  final _formKey = GlobalKey<FormState>();

  // Text controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _busStopController = TextEditingController();
  final _purposeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Registration'),
        shadowColor: Theme.of(context).shadowColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'Full Name',
                    hintText: 'Enter you full name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                    hintText: 'Enter you phone number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email Address',
                    hintText: 'Enter you email address',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: _busStopController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.bus_alert),
                    labelText: 'Bus Stop',
                    hintText: 'Enter you bus stop',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _purposeController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Purpose',
                    hintText: 'Enter you purpose',
                    border: OutlineInputBorder(),
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
