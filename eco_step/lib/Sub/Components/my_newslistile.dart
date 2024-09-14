import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_educlass.dart';

import 'my_educlass.dart';
class NewsArticlesList extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {'title': 'Factory at home. The Swiss are not against it.', 'date': '03.06.2024', 'time': '12 mins', 'image': 'assets/factory.png'},
    {'title': 'What the world largest tire cemetery looks like.', 'date': '01.02.2024', 'time': '19 mins', 'image': 'assets/rubber.png'},
    {'title': 'Oil Spill in the Black Sea', 'date': '07.08.2023', 'time': '7 mins', 'image': 'assets/oilspill.png'},
    {'title': 'Revolutionizing Home Manufacturing with New Technologies', 'date': '12.08.2024', 'time': '15 mins', 'image': 'assets/Homerev.jpeg'},
    {'title': 'Inside the World’s Largest Tire Dump: An Environmental Concern', 'date': '22.09.2023', 'time': '18 mins', 'image': 'assets/Tire.jpeg'},
    {'title': 'The Devastating Impact of Recent Oil Spills on Marine Life', 'date': '30.07.2024', 'time': '10 mins', 'image': 'assets/Revoilspil.jpeg'},
    {'title': 'Innovative Methods for Reducing Factory Waste', 'date': '05.10.2024', 'time': '13 mins', 'image': 'assets/Modernrecyle.jpeg'},
    {'title': 'Challenges in Managing Tire Waste: Global Perspectives', 'date': '14.11.2023', 'time': '21 mins', 'image': 'assets/tires-1.jpgchall.jpg'},
    {'title': 'Oil Spill Clean-Up Technologies and Their Effectiveness', 'date': '17.12.2023', 'time': '9 mins', 'image': 'assets/cleanupsolutions.jpeg'},
    {'title': 'How 3D Printing is Changing Factory Production', 'date': '25.01.2024', 'time': '14 mins', 'image': 'assets/3D.jpeg'},
    {'title': 'The Environmental Toll of Old Tire Dump Sites', 'date': '09.11.2023', 'time': '20 mins', 'image': 'assets/tiredump.jpeg'},
    {'title': 'Recent Advances in Oil Spill Prevention and Response', 'date': '04.03.2024', 'time': '8 mins', 'image': 'assets/Oilspillprevent.jpeg'},
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        var article = articles[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              width: 65,
              child: Image.asset(
                  article['image']!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(article['title']!,style: GoogleFonts.aclonica(fontSize: 15,),),
            subtitle: Text('${article['time']} • ${article['date']}',style: GoogleFonts.aboreto(fontSize: 15),),
            onTap: () {
              // Navigate to the details page for the tapped article
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailsPage(article: article),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
