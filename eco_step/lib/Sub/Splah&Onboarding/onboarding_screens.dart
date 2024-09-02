import 'package:flutter/material.dart';

import '../Components/onboard_content.dart';
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),

        actions: [
          TextButton(
            onPressed: _skipToLogin,
            child: Text('Skip', style: TextStyle(color: Colors.green[900])),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                OnboardingPage(
                  imageAsset: 'assets/trashcan.png',
                  title: 'Sort it right',
                  description: 'Scan the package or barcode \nand get information on proper waste disposal.',
                ),
                OnboardingPage(
                  imageAsset: 'assets/platictrashPerson.png',
                  title: 'Get Presents',
                  description: 'Go to events, read articles and earn eco-points.\nThese can be exchanged for presents',
                ),
                OnboardingPage(
                  imageAsset: 'assets/shoebag.png',
                  title: 'Exchange things',
                  description: '  Give a second life to your unwanted things.\nand find what you need.',
                ),
              ],
            ),
          ),
          _buildIndicator(),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentIndex == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentIndex == index ? Colors.green[900] : Colors.green[200],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 12,bottom: 16),
      child: ElevatedButton(
        onPressed: _currentIndex == 2 ? _goToLogin : _goToNextPage,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor:Theme.of(context).colorScheme.primary,
          padding: EdgeInsets.only(right: 15,left: 15),
        ),
        child: Text(_currentIndex == 2 ? 'Get Started' : 'Next',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary,
            fontSize: 16,
            fontWeight: FontWeight.bold),),
      ),
    );
  }

  void _goToNextPage() {
    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _skipToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
