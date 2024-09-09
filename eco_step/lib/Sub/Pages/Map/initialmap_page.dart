import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../Components/my_bottomnav.dart';
import '../../Components/my_map_widget.dart';
import '../../Components/my_search&filter_widget.dart';
import 'viewmap_page.dart';

class InitialMapPage extends StatefulWidget {
  @override
  _InitialMapPageState createState() => _InitialMapPageState();
}

class _InitialMapPageState extends State<InitialMapPage> with AutomaticKeepAliveClientMixin {
  int _selectedFilterIndex = 0;
  List<String> _filters = ['Glass', 'Battery', 'Metal', 'Paper', 'Recycling', 'Plastic', 'Electronics'];

  LatLng? _currentLocation;
  MapController _mapController = MapController();
  TextEditingController _searchController = TextEditingController();
  String? _searchQuery;

  // Toggle between satellite and standard map view
  bool isSatelliteView = false;

  // Recycling centers data (example)
  final List<RecyclingCenter> _recyclingCenters = [
    RecyclingCenter(name: 'Green Recycling Center', latitude: 37.7749, longitude: -122.4194),
    RecyclingCenter(name: 'Eco Recycle Hub', latitude: 37.7849, longitude: -122.4094),
    RecyclingCenter(name: 'Recycle Depot', latitude: 37.7649, longitude: -122.4294),
    RecyclingCenter(name: 'Sustainable Center', latitude: 37.7549, longitude: -122.4394),
    RecyclingCenter(name: 'Environment Hub', latitude: 37.7449, longitude: -122.4494),
    RecyclingCenter(name: 'Nature First Recycling', latitude: 37.7349, longitude: -122.4594),
  ];

  // OSM and Satellite map URLs
  final String standardMapUrl = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png";
  final String satelliteMapUrl = "https://api.maptiler.com/tiles/satellite-v2/{z}/{x}/{y}.jpg?key=RiplosyuyRWpMWtb5RpA";
  // https://api.maptiler.com/tiles/satellite-v2/{z}/{x}/{y}.jpg?key=RiplosyuyRWpMWtb5RpA
  // "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png"

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; // Retain state of the page

  // Fetch the current location
  void _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          return Future.error('Location permissions are permanently denied.');
        }
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

    } catch (e) {
      print('Error getting location: $e');
    }
  }

  // Handle search query changes
  void _onSearchChanged() {
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      setState(() {
        _navigateToSearchedMarker();  // Ensure setState wraps the navigation logic
      });
    }
  }

// Navigate to marker that matches the search query
  void _navigateToSearchedMarker() {
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final matchingCenter = _recyclingCenters.firstWhere(
            (center) => center.name.toLowerCase().contains(_searchQuery!.toLowerCase()),
        orElse: () => _recyclingCenters[0], // Default to the first marker if no match is found
      );

      setState(() {
        _mapController.move(LatLng(matchingCenter.latitude, matchingCenter.longitude), 18.0);  // Wrap movement in setState
      });
    }
  }

// Handle search icon pressed
  void _onSearchPressed() {
    setState(() {
      _navigateToSearchedMarker();  // Ensure setState wraps the navigation logic
    });
  }


  // Toggle between satellite and standard map view
  void _toggleMapView() {
    setState(() {
      isSatelliteView = !isSatelliteView;
    });
  }

  void _onFilterSelected(int index) async {
    setState(() {
      _selectedFilterIndex = index;
    });

    String selectedCategory = _filters[_selectedFilterIndex];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingAgentsListScreen(
          selectedCategory: selectedCategory,
        ),
      ),
    );
  }


  Marker? selectedMarker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check for returned agent from the RecyclingAgentsListScreen
    final agent = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    if (agent != null) {
      // Pick a random marker
      selectedMarker = _recyclingCenters[Random().nextInt(_recyclingCenters.length)] as Marker?;
      _startNavigation(selectedMarker!);  // Start navigation to this marker
    }
  }


  // In the _startNavigation method:
  void _startNavigation(Marker marker) {
    // Ensure _currentLocation is not null before proceeding
    if (_currentLocation == null) {
      print('Current location is not available.');
      return;
    }

    // Create a MapController to interact with the map
    final MapController mapController = MapController();

    // Focus map on the marker
    LatLng destinationLatLng = marker.point;
    mapController.move(destinationLatLng, 14); // Move and zoom to the marker

    // Drawing a polyline (example using two points - origin and destination)
    List<LatLng> route = [
      _currentLocation!, // Your current location
      destinationLatLng
    ];

    // Add your polyline to the map's polyline layer
    PolylineLayer polylineLayer = PolylineLayer(
      polylines: [
        Polyline(
          points: route,
          strokeWidth: 4.0,
          color: Colors.blue,
        ),
      ],
    );

    // When user reaches the destination, show the dialog to add eco points
    bool userReachedDestination = checkIfUserReachedDestination(_currentLocation!, destinationLatLng);
    if (userReachedDestination) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Congratulations!"),
            content: Text("You just earned 5 eco points."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  // Increment eco points in Firebase
                  incrementEcoPoints(5);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

// Ensure non-null location in checkIfUserReachedDestination
  bool checkIfUserReachedDestination(LatLng userLocation, LatLng destination) {
    final Distance distance = Distance();
    double distanceToDestination = distance.as(LengthUnit.Meter, userLocation, destination);
    return distanceToDestination < 50.0; // If within 50 meters, consider it reached
  }

  void incrementEcoPoints(int points) {
    // Add logic to increment eco points in Firebase
    final userId = 'user-id'; // Replace with actual user ID
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      final currentPoints = snapshot.data()?['ecoPoints'] ?? 0;
      transaction.update(userRef, {'ecoPoints': currentPoints + 5});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);  // Ensure state persistence

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
        backgroundColor: Theme.of(context).colorScheme.background.withOpacity(0.9),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for recycling center...',
                prefixIcon: IconButton(
                  onPressed: _onSearchPressed,
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Map with current location and recycling centers
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(6.5244, 3.3792), // Lagos, Nigeria as the default center
              initialZoom: 12.0,
              onMapReady: () {
                if (_currentLocation != null) {
                  _mapController.move(_currentLocation!, 15.0); // Move the map to the user's location when ready
                }
              },
            ),
            children: [
              // TileLayer based on the selected view (standard/satellite)
              TileLayer(
                urlTemplate: isSatelliteView ? satelliteMapUrl : standardMapUrl,
                subdomains: ['a', 'b', 'c'],
              ),
              // Markers for recycling centers
              MarkerLayer(
                markers: _recyclingCenters.map((center) {
                  return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(center.latitude, center.longitude),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  );
                }).toList(),
              ),
              // Marker for the current location
              if (_currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation!,
                      child: Icon(
                        Icons.my_location,
                        color: Colors.teal,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          // Search and filter widget
          Positioned(
            top: 10,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMapView,
        child: Icon(isSatelliteView ? Icons.satellite : Icons.map),
      ),
    );
  }
}

// Data model for recycling centers
class RecyclingCenter {
  final String name;
  final double latitude;
  final double longitude;

  RecyclingCenter({required this.name, required this.latitude, required this.longitude});
}
