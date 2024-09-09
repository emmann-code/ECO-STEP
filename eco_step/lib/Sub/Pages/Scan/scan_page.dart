import 'package:eco_step/Sub/Pages/Scan/scan_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Components/my_button.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;

  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (controller != null) {
  //     controller!.pauseCamera();
  //   }
  // }

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
      ),
      body: Stack(
        children: <Widget>[
          // buildQrView(context),
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
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Handle manual entry
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

  // Widget buildQrView(BuildContext context) {
  //   return QRView(
  //     key: qrKey,
  //     onQRViewCreated: _onQRViewCreated,
  //     overlay: QrScannerOverlayShape(
  //       borderColor: Colors.white,
  //       borderRadius: 10,
  //       borderLength: 30,
  //       borderWidth: 10,
  //       cutOutSize: MediaQuery.of(context).size.width * 0.8,
  //     ),
  //   );
  // }

  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //       // Navigate to details screen with the scanned data
  //       // fetchProductDetails(result!.code);
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
}
