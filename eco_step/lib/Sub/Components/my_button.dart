import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const MyButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.isLoading = false, // Add loading state parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: isLoading ? null : onTap, // Disable tap when loading
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isLoading
                ? SpinKitCircle( // Show Spinkit when loading
              color: Colors.white,
              size: 24.0,
            )
                : Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
