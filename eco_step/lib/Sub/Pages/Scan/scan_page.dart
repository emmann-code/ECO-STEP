import 'package:eco_step/Sub/Pages/Scan/scan_list.dart';
import 'package:eco_step/Sub/Pages/Scan/scannedlist_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Components/my_button.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');


  // Animation controller
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // Loop the animation

    // Initialize the Animation using the controller
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  String _barcode = '';
  bool _isFlashOn = false;

  // Toggle flashlight
  void _toggleFlashlight() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  // Function to scan barcode
  Future<void> scanBarcode() async {
    try {
      var result = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000', // Line color
        'Cancel',   // Cancel button text
        true,       // Show flash icon
        ScanMode.DEFAULT, // Scan mode (Barcode or QR code)
      );
      if (result != '-1') {
        setState(() {
          _barcode = result;
        });
        if (_barcode.isNotEmpty) {
          fetchProductData(_barcode); // Fetch data after scanning
        }
      }
    } catch (e) {
      print("Barcode scan failed: $e");
    }
  }

  // Function to fetch product data from OpenFoodFacts API
  Future<void> fetchProductData(String barcode) async {
    final url = Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Debug: Print the response to understand its structure
      print('Response data: $data');

      if (data['status'] == 1) {
        final product = data['product'];
        // Product Name
        final productName = product['product_name'] ?? 'Unknown Product';
        // Packaging Information
        final packaging = product['packaging'] is List
            ? product['packaging'].join(', ')
            : product['packaging'] ?? 'Unknown Packaging';
        // Image URL
        final image = product['selected_images']?['front']?['display']['url'] ?? 'Unknown Image';
        // Cap Material (Assuming it's part of the packaging or a related field)
        final capMaterial = product['cap_material'] ??
            product['packaging_material']?.firstWhere(
                  (material) => material.contains('cap'),
              orElse: () => 'Unknown Cap Material',
            );


        final materialType = _getMaterialType(packaging);
        final disposalInstructions = _getDisposalInstructions(materialType);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScannedlistDetailsItemDetailScreen(
              itemName: productName,
              itemImage: image,
              material: materialType,
              capMaterial: 'None', // Adjust as needed
              disposalRecommendations: disposalInstructions,
            ),
          ),
        );
      } else {
        _showErrorDialog('Product not found');
      }
    } else {
      _showErrorDialog('Failed to fetch product data');
    }
  }

// Helper method to get material type based on packaging
  String _getMaterialType(String packaging) {
    if (packaging.contains('plastic')) {
      return 'Plastic';
    } else if (packaging.contains('glass')) {
      return 'Glass';
    } else if (packaging.contains('paper')) {
      return 'Paper';
    } else {
      return 'Unknown';
    }
  }

// Helper method to get disposal instructions based on material type
  List<String> _getDisposalInstructions(String materialType) {
    switch (materialType) {
      case 'Plastic':
        return ['Recycle in the plastics bin.'];
      case 'Glass':
        return ['Recycle in the glass bin.'];
      case 'Paper':
        return ['Recycle in the paper bin.'];
      default:
        return ['Check local recycling guidelines.'];
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Scan',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: IconButton(
                onPressed: _toggleFlashlight,
                icon: Icon(_isFlashOn ? Icons.flashlight_off : Icons.flashlight_on),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     color: Colors.grey,
          //     child: Image.asset("assets/bottle.png",scale: 3,),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey,
              child: _animation == null
                  ? Container() // Prevent accessing the uninitialized animation
                  : RotationTransition(
                turns: _animation,
                child: Image.asset(
                  "assets/bottle.png",
                  scale: 3,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 16,
            right: 16,
            child: Image.asset("assets/scanner.png"),
          ),
          Positioned(
            bottom: 270,
            left: 16,
            right: 16,
            child: GestureDetector(
              onTap: scanBarcode,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 0.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: scanBarcode,
                      icon: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.background),
                    ),
                    Text(
                      'Scan Barcode',
                      style: TextStyle(color: Theme.of(context).colorScheme.background),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Theme.of(context).colorScheme.secondary,
                          filled: true,
                          border: OutlineInputBorder(),
                          labelText: 'Enter barcode manually',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _barcode = value;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_barcode.isNotEmpty) {
                          fetchProductData(_barcode);
                        } else {
                          _showErrorDialog('Please enter a valid barcode');
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(color: Theme.of(context).colorScheme.background),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                MyButton(
                  text: "Select from the list",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PackagingTypesScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
