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
        'imageUrl': 'https://www.google.com/imgres?q=images%20for%20recycling%20agents&imgur'
            'l=https%3A%2F%2Fd2wrwj382xgrci.cloudfront.net%2FPictures%2F480xany%2F0%2F4%2F8%2F10048_pre23.'
            '09_106493.jpg&imgrefurl=https%3A%2F%2Fpackagingeurope.com%2Fnews%2Fplastics-recyclers-europe-high'
            '-energy-prices-could-drive-recycling-companies-out-of-business%2F8759.article&docid=5ga7EyhJgKr09M&tb'
            'nid=cxmFyVXOahzIAM&vet=12''ahUKEwjH37zyrqGIAxXcVkEAHfWfIPMQM3oECEUQAA..i&w=480&h=360&hcb=2&ved=2ahUKEwj'
            'H37zyrqGIAxXcVkEAHfWfIPMQM3oECEUQAA',
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