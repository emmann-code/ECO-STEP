import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Pages/Scan/scan_list.dart';
import 'package:eco_step/Sub/Pages/Scan/scannedlist_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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
  QRViewController? _controller;
  final TextEditingController _barcodeController = TextEditingController();

  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // Loop the animation

    // Initialize the Animation using the controller
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller?.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  void _toggleFlashlight() {
    _controller?.toggleFlash();
  }

  void _scanQRCode() async {
    try {
      await _controller?.pauseCamera();
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),
      );

      if (result != null) {
        setState(() {
          _fetchProductData(result);
        });
      }
    } catch (e) {
      print("QR Code scan failed: $e");
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller?.scannedDataStream.listen((scanData) {
        _controller?.pauseCamera();
        Navigator.pop(context, scanData.code);
      });
    });
  }

  Future<void> _fetchProductData(String barcode) async {
    final url = Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == 1) {
        final product = data['product'];

        final productName = product['product_name']?.toString() ?? 'Unknown Product';
        final packagingData = product['packaging'] ?? 'Unknown Packaging';
        final packagingKey = (packagingData is Map && packagingData.containsKey('non_recyclable_and_non_biodegradable_materials'))
            ? 'non_recyclable_and_non_biodegradable_materials'
            : 'Unknown Packaging';
        final image = product['selected_images']?['front']?['display']?['url']?.toString() ?? 'Unknown Image';
        final capMaterial = product['cap_material']?.toString() ?? product['packaging_material']?.firstWhere(
              (material) => material.toString().contains('cap'),
          orElse: () => 'Unknown Cap Material',
        ).toString();

        final materialType = _getMaterialType(packagingKey);
        final disposalInstructions = _getDisposalInstructions(materialType);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScannedlistDetailsItemDetailScreen(
              itemName: productName,
              itemImage: image,
              material: materialType,
              capMaterial: capMaterial.toString(),
              disposalRecommendations: disposalInstructions,
            ),
          ),
        );

        _incrementEcoPoints(5);
      } else {
        _showErrorDialog('Product not found');
      }
    } else {
      _showErrorDialog('Failed to fetch product data');
    }
  }

  void _incrementEcoPoints(int points) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        final currentPoints = snapshot.data()?['ecoPoints'] ?? 0;
        transaction.update(userRef, {'ecoPoints': currentPoints + points});
      });
    }
  }

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

  void _handleBarcodeEntry() {
    final barcode = _barcodeController.text.trim();
    if (barcode.isNotEmpty) {
      _fetchProductData(barcode);
    }
  }

  Widget _buildManualBarcodeEntry() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _barcodeController,
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.secondary,
              filled: true,
              labelText: 'Enter Barcode Manually',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 16),
        ElevatedButton(
          onPressed: _handleBarcodeEntry,
          child: Text('Done',
            style: TextStyle(color: Theme.of(context).colorScheme.background),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ],
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
                icon: Icon(Icons.flashlight_on),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.grey,
              child: RotationTransition(
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
            child: _buildScanButton(),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Column(
              children: [
                _buildManualBarcodeEntry(),
                SizedBox(height: 10),
                MyButton(
                  text: "Select from the list",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  PackagingTypesScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanButton() {
    return GestureDetector(
      onTap: _scanQRCode,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _scanQRCode,
              icon: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.background),
            ),
            Text(
              'Scan Barcode',
              style: TextStyle(color: Theme.of(context).colorScheme.background),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// class ScanScreen extends StatefulWidget {
//   const ScanScreen({super.key});
//
//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }
//
// class _ScanScreenState extends State<ScanScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.red,);
//   }
// }
