import 'package:eco_step/Sub/Pages/Education/jionevent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, String> event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Event",style: GoogleFonts.roboto(fontSize: 20),),
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  '${event['image']}', // Event image URL
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, size: 18, color: Colors.green),
                        SizedBox(width: 4),
                        Text('53.283386, 24.228394', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('${event['date']}', style: TextStyle(fontSize: 14)),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      // Leave event action
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> JoinEventPage(event: event)));
                    },
                    child: Text('Join',style: TextStyle(color: Colors.white),),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    child: IconButton(
                      icon: Icon(Icons.share, color:Colors.white),
                      onPressed: () {
                        // Share event action
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title']!,
                  style: GoogleFonts.adamina(fontWeight: FontWeight.w400,fontSize: 25),),
                  SizedBox(height: 8),
                  Text(
                    'About',
                    style: GoogleFonts.roboto(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit, amet consectetur adipisicing elit. Nemo beatae molestiae corrupti sequi! Ipsum, dolorum, a natus deserunt inventore id soluta quos.',
                      style: GoogleFonts.abhayaLibre(fontSize: 17),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sponsored by: ${event['organizer']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.eco, size: 18, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text('375'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Timeline Event',
                    style: GoogleFonts.aboreto(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  ListTile(
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.event, color: Colors.green),
                    title: Text('Opening Event',style: GoogleFonts.roboto(fontSize: 18),),
                    subtitle: Text('${event['date']}, 11:00'),
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.event, color: Colors.green),
                    title: Text('Team Division & Delineating',style: GoogleFonts.roboto(fontSize: 18),),
                    subtitle: Text('${event['date']}, 11:25'),
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.event, color: Colors.green),
                    title: Text('Plastic Collection Competition',style: GoogleFonts.roboto(fontSize: 18),),
                    subtitle: Text('${event['date']}, 12:00'),
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.event, color: Colors.green),
                    title: Text('Tree Planting Ceremony',style: GoogleFonts.roboto(fontSize: 18),),
                    subtitle: Text('${event['date']}, 14:00'),
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.event, color: Colors.green),
                    title: Text('Environmental Awareness Workshop',style: GoogleFonts.roboto(fontSize: 18),),
                    subtitle: Text('${event['date']}, 16:00'),
                  ),
                  SizedBox(height: 10),

                  ListTile(
                    tileColor: Theme.of(context).colorScheme.inversePrimary,
                    contentPadding: EdgeInsets.only(left: 10),
                    leading: Icon(Icons.event, color: Colors.green),
                    title: Text('Closing Remarks & Celebration'),
                    subtitle: Text('${event['date']}, 18:00',style: GoogleFonts.roboto(fontSize: 18),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}









class ArticleDetailsPage extends StatelessWidget {
  final Map<String, String> article;

  ArticleDetailsPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          article['title']!,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image at the top (similar to the provided UI)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                article['image']!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),

            // Add time and date badges as in the UI
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.timer, size: 18, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        '${article['time']}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${article['date']}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Title
            Text(
              article['title']!,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            // Description / About section
            Text(
              'About',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              article['description'] ?? ' Lorem ipsum dolor sit, amet '
                  'consectetur adipisicing elit'
                  '. Nemo beatae molestiae corrupti sequi! Ipsum, '
                  'dolorum, a natus deserunt inventore id soluta quos. ',
              style: GoogleFonts.poppins(fontSize: 14),
            ),

            // Additional information if necessary
          ],
        ),
      ),
    );
  }
}
