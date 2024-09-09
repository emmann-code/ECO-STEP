import 'package:eco_step/Sub/Splah&Onboarding/onboarding_screens.dart';
import 'package:flutter/material.dart';
import '../Components/my_splash.dart';
import 'splash_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()), // Navigate to your home page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenUI(),
    );
  }
}
