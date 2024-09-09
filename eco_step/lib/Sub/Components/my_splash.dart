import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Splah&Onboarding/onboarding_screens.dart';

class SplashScreenUI extends StatefulWidget {

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  // @override
  // void initState() {
  //   super.initState();
  //   _navigateToHome();
  // }
  // //
  // _navigateToHome() async {
  //   await Future.delayed(Duration(seconds: 7), () {});
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => OnboardingScreen()), // Navigate to your home page
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/recylce.png', // Add your recycle icon here
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  'ECO-STEP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'with concern for the planet',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/leaf_border.png', // Add your bottom leaf border here
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
