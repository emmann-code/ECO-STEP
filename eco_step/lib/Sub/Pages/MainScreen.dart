import 'package:flutter/material.dart';
import '../Components/my_bottomnav.dart';
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
      body: _getSelectedScreen(),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onScanTapped: _onScanTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onScanTapped,
        child: Icon(Icons.qr_code_scanner),
        backgroundColor:Theme.of(context).colorScheme.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return InitialMapPage();
      case 1:
        return Center(child: Text("SHOP PAGE"));
      case 2:
        return Center(child: Text("EDUCATION PAGE"));
      case 3:
        return ProfilePage(email: String.fromEnvironment(""),);
      case 4:
      default:
        return ScanScreen(); // Default screen
    }
  }
}





// import 'package:flutter/material.dart';
// import '../Components/my_bottomnav.dart';
// import 'Map/initialmap_page.dart';
// import 'Profile/profile.dart';
// import 'Scan/scan_page.dart';
//
// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _getSelectedScreen(), // Replace with the logic for selecting your screen
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//         onScanTapped: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ScanScreen()),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => ScanScreen()),
//           // );
//         },
//         child: Icon(Icons.qr_code_scanner),
//         backgroundColor: Colors.teal,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
//
//   Widget _getSelectedScreen() {
//     // Add logic to return the appropriate screen based on _selectedIndex
//     switch (_selectedIndex) {
//       case 0:
//         return  InitialMapPage();
//       case 1:
//         return  Center(child: Text("SHOP PAGE"));
//       case 2:
//         return  Center(child: Text("EDUCATION PAGE"));
//       case 3:
//         return ProfilePage(username: '',);
//       default:
//         return InitialMapPage();
//     }
//   }
// }
//
//
//
//
// // import 'package:flutter/material.dart';
// //
// // import '../Components/my_bottomnav.dart';
// // import 'Map/initialmap_page.dart';
// // import 'Profile/profile.dart';
// //
// // class MainScreen extends StatefulWidget {
// //   @override
// //   _MainScreenState createState() => _MainScreenState();
// // }
// //
// // class _MainScreenState extends State<MainScreen> {
// //   int _selectedIndex = 0;
// //
// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }
// //
// //   List<Widget> _pages = [
// //     // Text("SCAN PAGE"), // Index 0
// //     InitialMapPage(),  // Index 1
// //     Center(child: Text("SHOP PAGE")), // Index 2
// //     Center(child: Text("EDUCATION PAGE")), // Index 3
// //     ProfilePage(username: 'John Michael'), // Index 4
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _pages[_selectedIndex],
// //       bottomNavigationBar: CustomBottomNavBar(
// //         selectedIndex: _selectedIndex,
// //         onItemTapped: _onItemTapped,
// //         onScanTapped: () {
// //           // Implement scan functionality here
// //         },
// //       ),
// //       floatingActionButton: _selectedIndex == 0
// //           ? FloatingActionButton(
// //         onPressed: () {
// //           // Handle scan action for the InitialMapPage
// //         },
// //         child: Icon(Icons.qr_code_scanner),
// //         backgroundColor: Colors.teal,
// //       )
// //           : null,
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //     );
// //   }
// // }
