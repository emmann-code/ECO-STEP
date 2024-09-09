import 'package:eco_step/Sub/Components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RouteInfoCard extends StatelessWidget {
  final String location;
  final String distance;
  final String time;
  final String address;
  final String workingHours;
  final String contactNumber;
  final String imageUrl;

  RouteInfoCard({
    required this.location,
    required this.distance,
    required this.time,
    required this.address,
    required this.workingHours,
    required this.contactNumber,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.background,
                child: Icon(Icons.location_pin, color: Theme.of(context).colorScheme.primary)),
            title: Text(location,style: GoogleFonts.mansalva(fontWeight: FontWeight.w400,fontSize: 20),),
            subtitle: Text('$distance  ||  $time',
                style: GoogleFonts.mansalva(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.grey)),
          ),
          Image.network(imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                  Column(
                    children: [
                      SizedBox(height: 10,),
                      Text('Working time and contacts',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(height: 4.0),
                      Text(
                        workingHours,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        contactNumber,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: MyButton(text: "START",
              onTap: (){
                Navigator.pop(context);
              },),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
