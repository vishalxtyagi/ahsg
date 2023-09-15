import 'package:busconnect/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

// Splash screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.asset("assets/images/logo_small.png",
                width: 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DotLottieLoader.fromAsset("assets/animations/school_bus.lottie",
                frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                  if (dotlottie != null) {
                    return Lottie.memory(dotlottie.animations.values.single);
                  } else {
                    return Image.asset("assets/images/school_bus.jpg");
                  }
                }),
          )
        ],
      ),
    );
  }
}
