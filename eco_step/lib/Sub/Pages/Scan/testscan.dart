import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BarcodeScannerScreen extends StatefulWidget {
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  String _scanResult = '';

  Future<void> _scanBarcode() async {
    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
        '#FF0000', // Line color
        'Cancel',   // Cancel button text
        true,       // Show flash icon
        ScanMode.BARCODE, // Scan mode (Barcode or QR code)
      );
      if (result != '-1') {
        setState(() {
          _scanResult = result;
        });
        // Use _scanResult to find disposal information
        _fetchDisposalInformation(result);
      }
    } catch (e) {
      // Handle errors
      print('Error scanning barcode: $e');
    }
  }


  Future<void> _fetchDisposalInformation(String barcode) async {
    // Implement your logic to fetch and display disposal information based on the barcode
    // For example query a database or API
    final apiUrl = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 1) {
          // Product found
          final product = data['product'];

          // Example: Extract material type and disposal instructions
          // Note: Open Food Facts may not have direct information about disposal, so you may need to infer or use additional data.
          final productName = product['product_name'] ?? 'Unknown Product';
          final packaging = product['packaging'] ?? 'Unknown Packaging';
          final image = product[ "selected_images"] ?? 'Uknown Image';
          // Sample logic to map packaging to material and disposal instructions
          String materialType;
          String disposalInstructions;

          if (packaging.contains('plastic')) {
            materialType = 'Plastic';
            disposalInstructions = 'Recycle in the plastics bin.';
          } else if (packaging.contains('glass')) {
            materialType = 'Glass';
            disposalInstructions = 'Recycle in the glass bin.';
          } else if (packaging.contains('paper')) {
            materialType = 'Paper';
            disposalInstructions = 'Recycle in the paper bin.';
          } else {
            materialType = 'Unknown';
            disposalInstructions = 'Check local recycling guidelines.';
          }

          setState(() {
            _scanResult = 'Product: $productName\nMaterial: $materialType\nDisposal: $disposalInstructions';
          });
        } else {
          // Product not found
          setState(() {
            _scanResult = 'Product not found in Open Food Facts database.';
          });
        }
      } else {
        // Handle API errors
        setState(() {
          _scanResult = 'Error fetching product information. Please try again.';
        });
      }
    } catch (e) {
      // Handle network errors
      print('Error fetching disposal information: $e');
      setState(() {
        _scanResult = 'An error occurred. Please try again later.';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Scan result: $_scanResult',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Scan Barcode'),
            ),
          ],
        ),
      ),
    );
  }
}




class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
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
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Button to scan barcode
            ElevatedButton.icon(
              onPressed: scanBarcode,
              icon: Icon(Icons.camera_alt),
              label: Text('Scan Barcode'),
            ),
            SizedBox(height: 20),

            // Button to toggle flashlight
            ElevatedButton.icon(
              onPressed: _toggleFlashlight,
              icon: Icon(_isFlashOn ? Icons.flashlight_off : Icons.flashlight_on),
              label: Text(_isFlashOn ? 'Turn Off Flashlight' : 'Turn On Flashlight'),
            ),
            SizedBox(height: 20),

            // Text field for manual barcode input
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Barcode Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _barcode = value;
              },
            ),
            SizedBox(height: 10),

            // Button to fetch data manually from API
            ElevatedButton(
              onPressed: () {
                if (_barcode.isNotEmpty) {
                  fetchProductData(_barcode);
                } else {
                  _showErrorDialog('Please enter a valid barcode');
                }
              },
              child: Text('Fetch Product Information'),
            ),
          ],
        ),
      ),
    );
  }
}
