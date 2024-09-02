import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final VoidCallback onScanTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onScanTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.background,
      shape: const CircularNotchedRectangle(),
      notchMargin: 12.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildNavItem(icon: Icons.location_on_outlined, label: 'Map', index: 0),
          _buildNavItem(icon: Icons.store, label: 'Shop', index: 1),
          SizedBox(width: 40.0), // Spacer for the FAB
          _buildNavItem(icon: Icons.lightbulb, label: 'Education', index: 2),
          _buildNavItem(icon: Icons.person, label: 'Profile', index: 3),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: selectedIndex == index ? Colors.teal : Colors.black54,
          ),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.teal : Colors.grey,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';
//
// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onItemTapped;
//   final VoidCallback onScanTapped;
//
//   const CustomBottomNavBar({
//     Key? key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//     required this.onScanTapped,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomAppBar(
//       color: Theme.of(context).colorScheme.background,
//       height: 65,
//       shape: CircularNotchedRectangle(),
//       notchMargin: 16.0,
//       child: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: <Widget>[
//             _buildNavItem(icon: Icons.location_on_outlined, label: 'Map', index: 0,),
//             _buildNavItem(icon: Icons.store, label: 'Shop', index: 1),
//             SizedBox(width: 25.0), // Spacer for the scan button
//             _buildNavItem(icon: Icons.lightbulb, label: 'Education', index: 2),
//             _buildNavItem(icon: Icons.person, label: 'Profile', index: 3),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavItem({required IconData icon, required String label, required int index}) {
//     return GestureDetector(
//       onTap: () => onItemTapped(index),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Icon(
//             icon,
//             color: selectedIndex == index ? Colors.teal : Colors.grey,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: selectedIndex == index ? Colors.teal : Colors.grey,
//               fontSize: 12.0,
//               fontWeight: FontWeight.bold
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
