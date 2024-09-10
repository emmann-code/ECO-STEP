import 'package:eco_step/Sub/Pages/Scan/scan_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Components/my_button.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String _barcode = '';
  bool _isFlashOn = false;

  // Toggle flashlight
  void _toggleFlashlight() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  String _scanResult = '';

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
        // if (result.rawContent.isNotEmpty) {
        //   setState(() {
        //     _barcode = result.rawContent;
        //   });
        fetchProductData(_barcode); // Fetch data after scanning
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
      if (data['status'] == 1) {
        String packaging = data['product']['packaging'] ?? 'Unknown';
        _showProductDetails(barcode, packaging);
      } else {
        _showErrorDialog('Product not found');
      }
    } else {
      _showErrorDialog('Failed to fetch product data');
    }
  }

  // Show product details in a new screen or dialog
  void _showProductDetails(String barcode, String packaging) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Product Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Barcode: $barcode'),
              SizedBox(height: 10),
              Text('Packaging: $packaging'),
            ],
          ),
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
        title: Text('Scan',style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          //   label: Text(_isFlashOn ? 'Turn Off Flashlight' : 'Turn On Flashlight'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: IconButton(
                onPressed: _toggleFlashlight,
                icon:Icon(_isFlashOn ? Icons.flashlight_off : Icons.flashlight_on),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          // buildQrView(context),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // color: Color(0xFF38745B),
              color: Colors.grey,
              child: Image(image: AssetImage("assets/bottle.png")),
            ),
          ),
          Positioned(
              bottom: 80,
              left: 16,
              right: 16,
              child: Image(image: AssetImage("assets/scanner.png")
              )),
          Positioned(
              bottom: 230,
              left: 16,
              right: 16,
              child:
              GestureDetector(
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
                          icon: Icon(Icons.camera_alt,
                            color: Theme.of(context).colorScheme.background,)),
                      Text(
                        'Scan Barcode',
                        style: TextStyle(color: Theme.of(context).colorScheme.background,),
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
                      // Button to fetch data manually from API
                      onPressed: () {
                        if (_barcode.isNotEmpty) {
                          fetchProductData(_barcode);
                        } else {
                          _showErrorDialog('Please enter a valid barcode');
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(color: Theme.of(context).colorScheme.background,),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PackagingTypesScreen()));
                      // Handle selection from the list
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
