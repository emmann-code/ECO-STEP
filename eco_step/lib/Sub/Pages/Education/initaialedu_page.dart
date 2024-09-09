import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/my_carouselsevents.dart';
import '../../Components/my_newslistile.dart';

class EducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('Education', style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('Nearby Events',style: GoogleFonts.aboreto(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            NearbyEventsCarousel(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text('News & Articles',style: GoogleFonts.mansalva(fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            NewsArticlesList(),
          ],
        ),
      ),
    );
  }
}
