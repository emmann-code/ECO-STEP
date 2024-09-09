import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/my_bottomnav.dart';
import '../../Components/my_routemap.dart';
class RecyclingAgentsListScreen extends StatefulWidget {
  final String selectedCategory;

  RecyclingAgentsListScreen({required this.selectedCategory});

  @override
  State<RecyclingAgentsListScreen> createState() => _RecyclingAgentsListScreenState();
}

class _RecyclingAgentsListScreenState extends State<RecyclingAgentsListScreen> {
  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    // Example data - in real implementation, you'd fetch data from an API
    List<Map<String, String>> agents = [
      {
        'location': 'Battery recycling',
        'distance': '2.81 km',
        'time': '34 min',
        'address': 'Libava-Romensksaja St. 11A',
        'workingHours': 'MONDAY - FRIDAY: 15.00 - 20.00\nSATURDAY - SUNDAY: 09.00 - 12.00',
        'contactNumber': '+375(29)777-98-89',
        'imageUrl': "https://www.pncc.govt.nz/files/assets"
            "/public/v/3/images/services/rubbish-amp-recycling/recycling-facility.jpg?w=1200",
      },
      // Add more agents as needed
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
        title: Text('${widget.selectedCategory} Recycling Companies',
          style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
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
            imageUrl: agent["imageUrl"]!,
          );
        },
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   selectedIndex:_selectedIndex,
      //   onItemTapped: _onItemTapped,
      //   onScanTapped: () {
      //     // Implement scan functionality here
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Handle scan action
      //   },
      //   child: Icon(Icons.qr_code_scanner),
      //   backgroundColor: Colors.teal,
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}