import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_educlass.dart';
class NewsArticlesList extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {'title': 'Factory at home. The Swiss are not against it.', 'date': '03.06.2024', 'time': '12 mins', 'image': 'assets/factory.png'},
    {'title': 'What the world largest tire cemetery looks like.', 'date': '01.02.2024', 'time': '19 mins', 'image': 'assets/rubber.png'},
    {'title': 'Oil Spill in the Black Sea', 'date': '07.08.2023', 'time': '7 mins', 'image': 'assets/oilspill.png'},
    {'title': 'Revolutionizing Home Manufacturing with New Technologies', 'date': '12.08.2024', 'time': '15 mins', 'image': 'assets/factory.png'},
    {'title': 'Inside the World’s Largest Tire Dump: An Environmental Concern', 'date': '22.09.2023', 'time': '18 mins', 'image': 'assets/rubber.png'},
    {'title': 'The Devastating Impact of Recent Oil Spills on Marine Life', 'date': '30.07.2024', 'time': '10 mins', 'image': 'assets/oilspill.png'},
    {'title': 'Innovative Methods for Reducing Factory Waste', 'date': '05.10.2024', 'time': '13 mins', 'image': 'assets/factory.png'},
    {'title': 'Challenges in Managing Tire Waste: Global Perspectives', 'date': '14.11.2023', 'time': '21 mins', 'image': 'assets/rubber.png'},
    {'title': 'Oil Spill Clean-Up Technologies and Their Effectiveness', 'date': '17.12.2023', 'time': '9 mins', 'image': 'assets/oilspill.png'},
    {'title': 'How 3D Printing is Changing Factory Production', 'date': '25.01.2024', 'time': '14 mins', 'image': 'assets/factory.png'},
    {'title': 'The Environmental Toll of Old Tire Dump Sites', 'date': '09.11.2023', 'time': '20 mins', 'image': 'assets/rubber.png'},
    {'title': 'Recent Advances in Oil Spill Prevention and Response', 'date': '04.03.2024', 'time': '8 mins', 'image': 'assets/oilspill.png'},
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        var article = articles[index];
        return ListTile(
          leading: Image.asset(article['image']!),
          title: Text(article['title']!,style: GoogleFonts.ramaraja(fontSize: 20),),
          subtitle: Text('${article['time']} • ${article['date']}',style: GoogleFonts.aboreto(fontSize: 14),),
          onTap: () {
            // Navigate to the details page for the tapped article
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailsPage(article: article),
              ),
            );
          },
        );
      },
    );
  }
}
