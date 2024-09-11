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