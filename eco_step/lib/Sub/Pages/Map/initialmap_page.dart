import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import '../../Components/my_bottomnav.dart';
import '../../Components/my_map_widget.dart';
import '../../Components/my_search&filter_widget.dart';
import 'listmap_page.dart';

class InitialMapPage extends StatefulWidget {
  @override
  _InitialMapPageState createState() => _InitialMapPageState();
}

class _InitialMapPageState extends State<InitialMapPage> {
  int _selectedFilterIndex = 0;
  List<String> _filters = ['Glass', 'Battery', 'Metal', 'Paper', 'Recycling', 'Plastic', 'Electronics'];

  List<Marker> _markers = [];

  void _onFilterSelected(int index) async {
    setState(() {
      _selectedFilterIndex = index;
    });

    String selectedCategory = _filters[_selectedFilterIndex];
    List<Marker> newMarkers = await _fetchRecyclingCenters(selectedCategory);

    setState(() {
      _markers = newMarkers;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingAgentsListScreen(
          selectedCategory: selectedCategory,
        ),
      ),
    );
  }

  LatLng? _currentLocation;
  MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    try{
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }

      // Check for location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied.');
      }

      // Fetch the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      );
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        // Center the map on the user's location
        _mapController.move(_currentLocation!, 15.0);
      });
    }catch(e){
      // Handle the timeout or any other error
      print('Error getting location: $e');
    }
  }

  Future<List<Marker>> _fetchRecyclingCenters(String category) async {
    // Replace these coordinates with the actual bounding box of the map view
    double minLat = 51.509865, minLon = -0.118092, maxLat = 51.515617, maxLon = -0.091998;

    String overpassQuery = '''
    [out:json];
    (
      node["amenity"="$category"]
      ($minLat,$minLon,$maxLat,$maxLon);
    );
    out body;
    ''';

    final response = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      body: {
        'data': overpassQuery,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> elements = List<Map<String, dynamic>>.from(data['elements']);

      List<Marker> markers = elements.map((element) {
        return Marker(
          point: LatLng(element['lat'], element['lon']),
          child: Icon(Icons.location_on, color: Colors.teal, size: 40.0),
        );
      }).toList();

      return markers;
    } else {
      throw Exception('Failed to load recycling centers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Map",
          style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Only show the map if the location is available
          if (_currentLocation != null)
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation!,
                initialZoom: 25.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      width: 40.0,
                      height: 40.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.teal,
                        size: 40.0,
                      ),
                    ),
                    ..._markers, // Include other markers
                  ],
                ),
              ],
            ),
          if (_currentLocation == null)
            Center(child: CircularProgressIndicator()),

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
    );
  }

// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
  //     appBar: AppBar(
  //       title: Text(
  //         "Map",
  //         style: GoogleFonts.roboto(
  //           fontSize: 30,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
  //       elevation: 0,
  //     ),
  //     body: Stack(
  //       children: [
  //         MapWidget(markers: _markers),
  //         Positioned(
  //           top: 0,
  //           left: 0,
  //           right: 0,
  //           child: SearchAndFilterWidget(
  //             filters: _filters,
  //             selectedIndex: _selectedFilterIndex,
  //             onFilterSelected: _onFilterSelected,
  //           ),
  //         ),
  //         _currentLocation == null
  //             ? Center(child: CircularProgressIndicator())
  //             : FlutterMap(
  //           mapController: _mapController,
  //           options: MapOptions(
  //             initialCenter: _currentLocation ?? LatLng(0.0, 0.0), // Provide a fallback location
  //             initialZoom: 15.0,
  //           ),
  //           children: [
  //             TileLayer(
  //               urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
  //               subdomains: ['a', 'b', 'c'],
  //             ),
  //             MarkerLayer(
  //               markers: _currentLocation != null
  //                   ? [
  //                 Marker(
  //                   point: _currentLocation!,
  //                   width: 40.0,
  //                   height: 40.0,
  //                   child: Icon(
  //                     Icons.location_on,
  //                     color: Colors.teal,
  //                     size: 40.0,
  //                   ),
  //                 ),
  //               ]
  //                   : [],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
