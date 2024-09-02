// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class ScanScreen extends StatefulWidget {
//   @override
//   _ScanScreenState createState() => _ScanScreenState();
// }
//
// class _ScanScreenState extends State<ScanScreen> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//   Barcode? result;
//   QRViewController? controller;
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text('Scan', style: TextStyle(color: Colors.black)),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           QRView(
//             key: qrKey,
//             onQRViewCreated: _onQRViewCreated,
//           ),
//           Center(
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.white, width: 2),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Opacity(
//                     opacity: 0.7,
//                     child: Image.asset(
//                       'assets/bottle.png', // Replace with your asset
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     child: Text(
//                       'Scanning... 15%',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 100,
//             left: 16,
//             right: 16,
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     border: OutlineInputBorder(),
//                     labelText: 'Enter barcode manually',
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle manual entry
//                   },
//                   child: Text('Done'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.teal,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextButton(
//                   onPressed: () {
//                     // Handle selection from the list
//                   },
//                   child: Text('Select from the list'),
//                   style: TextButton.styleFrom(
//                     foregroundColor: Colors.teal,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
// }
