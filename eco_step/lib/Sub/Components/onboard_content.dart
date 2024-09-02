import 'package:flutter/material.dart';
class OnboardingPage extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;

  const OnboardingPage({
    required this.imageAsset,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imageAsset),
        SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.green[900]),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
