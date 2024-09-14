import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventPage extends StatelessWidget {
  final String userEmail;

  const MyEventPage({Key? key, required this.userEmail}) : super(key: key);

  // Function to retrieve events the user has signed up for
  Stream<QuerySnapshot> getUserEvents() {
    return FirebaseFirestore.instance
        .collection('eventRegistrations')
        .where('email', isEqualTo: userEmail)
        .orderBy('joinDate', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Events',
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getUserEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading events.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('You haven\'t signed up for any events yet.'));
          }

          final events = snapshot.data!.docs;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              final eventData = event['event'];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    eventData['title'] ?? 'No Title',
                    style: GoogleFonts.roboto(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date: ${eventData['date']}'),
                      Text('Location: ${eventData['location'] ?? 'No Location'}'),
                      Text('Details: ${eventData['details'] ?? 'No Details'}'),
                      Text('Join Date: ${event['joinDate'].toDate()}'),
                    ],
                  ),
                  leading: eventData['image'] != null
                      ? Image.asset(
                    eventData['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                      : Icon(Icons.event),
                  onTap: () {
                    // Navigate to detailed event page if needed
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
