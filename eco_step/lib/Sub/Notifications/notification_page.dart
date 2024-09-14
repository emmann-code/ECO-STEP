import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications;

  const NotificationsPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications', style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.secondary,
              title: Text(notification['title']!),
              subtitle: Text(notification['body']!),
              trailing: Text(notification['name']!),
            ),
          );
        },
      ),
    );
  }
}
