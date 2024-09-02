import 'package:flutter/material.dart';

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
            leading: Icon(Icons.location_pin, color: Theme.of(context).colorScheme.primary),
            title: Text(location),
            subtitle: Text('$distance | $time'),
          ),
          Image.network(imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Start'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
