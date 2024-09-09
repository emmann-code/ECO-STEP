import 'package:eco_step/Sub/Pages/Profile/about_app.dart';
import 'package:eco_step/Sub/Pages/Profile/editprofile.dart';
import 'package:eco_step/Sub/Pages/Profile/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(tileColor: Theme.of(context).colorScheme.secondary,
            title: Text('Edit personal information',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),
            ),
            onTap: () {
              // Navigate to Edit Personal Information Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => Editprofile()));
            },
            trailing: Icon(Icons.person_outline, color: Colors.black),
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text('My events',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),),
            onTap: () {
              // Navigate to My Events Page
            },
            trailing: Icon(Icons.event, color: Colors.black),
            tileColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 13,),
          ListTile(
            title: Text('Settings',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),),
            onTap: () {
              // Navigate to Settings Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            trailing: Icon(Icons.settings, color: Colors.black),
            tileColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 10,),
          ListTile(
            title: Text('About the App',style: GoogleFonts.roboto(
              fontSize: 13,
              fontWeight: FontWeight.bold,),),
            onTap: () {
              // Navigate to About the App Page
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutApp()));
            },
            trailing:  Icon(Icons.info_outline, color: Colors.black),
            tileColor:Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
