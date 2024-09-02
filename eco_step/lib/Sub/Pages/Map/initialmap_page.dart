import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../Components/bottomnav.dart';
import '../Components/map_widget.dart';
import '../Components/search&filter_widget.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  int _selectedFilterIndex = 0;
  List<String> _filters = ['Glass', 'Battery', 'Metal', 'Paper', 'Recycling', 'Plastic', 'Electronics'];

  List<Marker> _markers = [
    Marker(
      child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
      point: LatLng(51.509865, -0.118092),
    ),
    Marker(
      point: LatLng(51.503364, -0.127625),
      child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
    ),
    Marker(
      point: LatLng(51.515617, -0.091998),
      child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
    ),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFilterSelected(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingAgentsListScreen(
          selectedCategory: _filters[_selectedFilterIndex],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      appBar: AppBar(
        title: Text(
          "Map",
          style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Stack(
        children: [
          MapWidget(markers: _markers),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SearchAndFilterWidget(
              filters: _filters,
              selectedIndex: _selectedFilterIndex,
              onFilterSelected: _onFilterSelected,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onScanTapped: () {
          // Implement scan functionality here
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle scan action
        },
        child: Icon(Icons.qr_code_scanner),
        backgroundColor: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import '../Components/textfield.dart';
// import '../Components/bottomnav.dart';
// import '../Components/filterbutton.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   int _selectedFilterIndex = 0;
//   List<String> _filters = ['Glass', 'Battery', 'Metal', 'Paper', 'Recycling', 'Plastic', 'Electronics'];
//
//   // Example markers with LatLng positions
//   List<Marker> _markers = [
//     Marker(
//       child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
//       point: LatLng(51.509865, -0.118092),
//     ),
//     Marker(
//       point: LatLng(51.503364, -0.127625),
//       child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
//     ),
//     Marker(
//       point: LatLng(51.515617, -0.091998),
//       child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
//     ),
//   ];
//
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   void _onFilterSelected(int index) {
//     setState(() {
//       _selectedFilterIndex = index;
//       // Update _markers based on the selected filter (this could involve a data fetch)
//       // For simplicity, we're using static markers here
//     });
//
//     // Navigate to a new screen with a ListView of recycling agents
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => RecyclingAgentsListScreen(
//           selectedCategory: _filters[_selectedFilterIndex],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
//       appBar: AppBar(
//         title: Text(
//           "Map",
//           style: GoogleFonts.roboto(
//             fontSize: 30,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           // OpenStreetMap integration using flutter_map
//           FlutterMap(
//             options: MapOptions(
//               initialCenter: LatLng(51.509865, -0.118092), // Default location
//               initialZoom: 13.0,
//             ),
//             children: [
//               TileLayer(
//                 urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                 subdomains: ['a', 'b', 'c'],
//               ),
//               MarkerLayer(
//                 markers: _markers, // List of Marker objects
//               ),
//             ],
//           ),
//           // Overlay for search bar and filters
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextfield(
//                   title: 'Search',
//                 ),
//                 SizedBox(height: 10.0),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: FilterButtons(
//                     filters: _filters,
//                     selectedIndex: _selectedFilterIndex,
//                     onSelected: _onFilterSelected,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//         onScanTapped: () {
//           // Implement scan functionality here
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle scan action
//         },
//         child: Icon(Icons.qr_code_scanner),
//         backgroundColor: Colors.teal,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }

class RecyclingAgentsListScreen extends StatelessWidget {
  final String selectedCategory;

  RecyclingAgentsListScreen({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    // Example data - in real implementation, you'd fetch data from an API
    List<Map<String, String>> agents = [
      {
        'location': 'Battery recycling',
        'distance': '2.81 km',
        'time': '34 min',
        'address': 'Libava-Romensksaja St. 11A',
        'workingHours': 'MONDAY - FRIDAY: 15.00 - 20.00\nSATURDAY - SUNDAY: 09.00 - 12.00',
        'contactNumber': '+375(29)777-98-89',
        'imageUrl': 'https://example.com/image.jpg',
      },
      // Add more agents as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedCategory Recycling Agents'),
      ),
      body: ListView.builder(
        itemCount: agents.length,
        itemBuilder: (context, index) {
          final agent = agents[index];
          return RouteInfoCard(
            location: agent['location']!,
            distance: agent['distance']!,
            time: agent['time']!,
            address: agent['address']!,
            workingHours: agent['workingHours']!,
            contactNumber: agent['contactNumber']!,
            imageUrl: agent['imageUrl']!,
          );
        },
      ),
    );
  }
}

// Example of RouteInfoCard
class RouteInfoCard extends StatelessWidget {
  final String location;
  final String distance;
  final String time;
  final String address;
  final String workingHours;
  final String contactNumber;
  final String imageUrl;

  RouteInfoCard({
    required this.location,
    required this.distance,
    required this.time,
    required this.address,
    required this.workingHours,
    required this.contactNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl), // Displaying image from URL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(location, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$distance • $time • $address'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Working Hours: $workingHours'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Contact: $contactNumber'),
          ),
        ],
      ),
    );
  }
}































// import 'package:flutter/material.dart';
// import '../Components/textfield.dart';
// import '../Components/bottomnav.dart';
// import '../Components/filterbutton.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   int _selectedFilterIndex = 0;
//   List<String> _filters = ['Glass', 'Battery', 'Metal', 'Paper', 'Recycling'];
//   List<Map<String, dynamic>> _markers = [
//     {'icon': Icons.location_on, 'top': 150.0, 'left': 100.0},
//     {'icon': Icons.location_on, 'top': 200.0, 'left': 200.0},
//     {'icon': Icons.location_on, 'top': 300.0, 'left': 250.0},
//     // Add more markers as needed
//   ];
//
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
//       backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
//       appBar: AppBar(
//         title: Text("Map",
//             // charmonman
//           style: GoogleFonts.roboto(
//               fontSize: 30,
//               color: Colors.black,
//             fontWeight: FontWeight.bold
//             ),),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           // Map image or map view
//           Positioned.fill(
//             child: Image.asset(
//               'assets/Map.png', // Replace with your map image asset
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Overlay for search bar and filters
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomTextfield(
//                   title: 'Search',
//                 ),
//                 SizedBox(height: 10.0),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: FilterButtons(
//                     filters: _filters,
//                     selectedIndex: _selectedFilterIndex,
//                     onSelected: (index) {
//                       setState(() {
//                         _selectedFilterIndex = index;
//                         // Update _markers based on the selected filter
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Markers overlay
//           ..._markers.map((marker) {
//             return Positioned(
//               top: marker['top'],
//               left: marker['left'],
//               child: Icon(
//                 marker['icon'],
//                 size: 40.0,
//                 color: Colors.teal,
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onItemTapped: _onItemTapped,
//         onScanTapped: () {
//           // Implement scan functionality here
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Handle scan action
//         },
//         child: Icon(Icons.qr_code_scanner),
//         backgroundColor: Colors.teal,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
//
// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.red,
//     );
//   }
// }
