import 'package:eco_step/Sub/Pages/MainScreen.dart';
import 'package:eco_step/Sub/Pages/Map/initialmap_page.dart';
import 'package:eco_step/Sub/Pages/Scan/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final String material;
  final String capMaterial;
  final List<String> disposalRecommendations;

  ItemDetailScreen({
    required this.itemName,
    required this.itemImage,
    required this.material,
    required this.capMaterial,
    required this.disposalRecommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Scan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100,left: 16,right: 16),
        child: Column(
          children: [
            Image.asset(itemImage, height: 150.0),
            SizedBox(height: 20.0),
            Text(
              itemName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Bottle material: $material',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Cap material: $capMaterial',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Disposal recommendations:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            ...disposalRecommendations.map((recommendation) => Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                recommendation,
                style: TextStyle(fontSize: 16.0),
              ),
            )),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    side: BorderSide(width: 2)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
                  },
                  child: Text('Scan again',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> InitialMapPage()));
                  },
                  child: Text('Find a recycling cntr',style: TextStyle(color: Theme.of(context).colorScheme.background,),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
