import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreenUI extends StatelessWidget {
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
