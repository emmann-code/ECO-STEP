import 'package:eco_step/Sub/Pages/MainScreen.dart';
import 'package:eco_step/Sub/Pages/Map/initialmap_page.dart';
import 'package:eco_step/Sub/Pages/Scan/scan_list.dart';
import 'package:eco_step/Sub/Pages/Scan/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScannedlistDetailsItemDetailScreen extends StatelessWidget {
  final String itemName;
  final String itemImage;
  final String material;
  final String capMaterial;
  final List<String> disposalRecommendations;

  ScannedlistDetailsItemDetailScreen({
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
            Image.network(itemImage, height: 150.0),
            SizedBox(height: 10.0),
            Text(
              itemName,
              style: GoogleFonts.racingSansOne(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Packaging: $material',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Cap material: $capMaterial',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Disposal recommendations:',
              style: GoogleFonts.aboreto(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...disposalRecommendations.map((recommendation) => Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                recommendation,
                style: GoogleFonts.roboto(
                  fontSize: 16,),
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
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("If Item Data is not found pls refer \nto list to get info. ", style: GoogleFonts.roboto(fontSize: 20,),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PackagingTypesScreen()),
                    );
                  },
                    child: Text("Select item",style: TextStyle(color: Colors.greenAccent,fontWeight: FontWeight.bold,fontSize: 12),)
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
