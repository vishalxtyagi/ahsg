import 'package:flutter/material.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:lottie/lottie.dart';

// Splash screen
class UnavailableScreen extends StatefulWidget {
  @override
  _UnavailableScreenState createState() => _UnavailableScreenState();
}

class _UnavailableScreenState extends State<UnavailableScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: DotLottieLoader.fromAsset("assets/animations/coming_soon.lottie",
                  frameBuilder: (BuildContext ctx, DotLottie? dotlottie) {
                    if (dotlottie != null) {
                      return Lottie.memory(dotlottie.animations.values.single);
                    } else {
                      return Image.asset("assets/images/school_bus.jpg");
                    }
                  }),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text('This feature is not available yet.'),
          )
        ],
      ),
    );
  }
}
