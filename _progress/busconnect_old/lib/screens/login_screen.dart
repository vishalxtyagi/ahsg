import 'package:busconnect/screens/main_screen.dart';
import 'package:busconnect/screens/registration/student_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'registration/guest_registration_screen.dart';

// Login screen with Google sign-in 
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User> _signInWithGoogle() async {
    // Trigger Google Sign-In and get authentication details
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create AuthCredential from access token
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with credential
    final User? user = (await _auth.signInWithCredential(credential)).user;

    // Check if user already exists in Firestore
    final uid = user!.uid;
    final userDoc = await _db.collection('users').doc(uid).get();

    if (userDoc.exists) {
      // Continue to app
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen())
      );
    } else {
      // Navigate to registration
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StudentRegistrationScreen())
      );
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: DotLottieLoader.fromAsset("assets/animations/authentication.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                    if (dotlottie != null) {
                      return Lottie.memory(dotlottie.animations.values.single,
                        repeat: false,
                        height: 256
                      );
                    } else {
                      return Image.asset("assets/images/school_bus.jpg");
                    }
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(
                    height: 50,
                    width: 250,
                    child: FilledButton(
                          onPressed: () async {
                            await _signInWithGoogle();
                          },
                          child: Text('Continue as student'),
                        ),
                  margin: EdgeInsets.only(bottom: 10),
                ),
                Container(
                  height: 50,
                  width: 250,
                  margin: EdgeInsets.zero,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GuestRegistrationScreen()),
                      );
                    },
                    child: Text('Guest Register'),
                  ),
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}
