import 'package:eco_step/Sub/Pages/Education/initaialedu_page.dart';
import 'package:eco_step/Sub/Pages/Scan/testscan.dart';
import 'package:flutter/material.dart';
import '../Components/my_bottomnav.dart';
import 'BenefitShop/buildshop_product.dart';
import 'Map/initialmap_page.dart';
import 'Profile/profile.dart';
import 'Scan/scan_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 4; // Start with 4 as the index for ScanScreen

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScanTapped() {
    setState(() {
      _selectedIndex = 4; // Index for ScanScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.7),
      body: _getSelectedScreen(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onScanTapped: _onScanTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onScanTapped,
        child: Icon(Icons.qr_code_scanner),
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return InitialMapPage();
        // return BarcodeScannerPage();
        // return BarcodeScannerScreen();
      case 1:
        return BenefitShop(email: String.fromEnvironment(""));
      case 2:
        return  EducationScreen();
      case 3:
        return ProfilePage(email: String.fromEnvironment(""),);
      case 4:
      default:
        return ScanScreen(); // Default screen
    }
  }
}