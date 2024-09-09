import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Components/my_settingTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Components/my_profilepic.dart';
import '../../Services/auth/auth_service.dart';
import '../../Services/auth/login_or_register.dart';
import '../../Themes/theme_provider.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  String? get email => email;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String? _profileImageUrl;  // This will store the profile image URL

  void logout(){
    final authService = AuthService();
    authService.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginOrRegister()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('Settings',style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Profilepic(
                  onImageSelected: (String imagePath) {
                    // You can use this to allow updating the image from here as well
                  },
                  imageUrl: _profileImageUrl,  // Pass the image URL here
                ),
                SizedBox(width: 130),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed:logout,
                      child: Row(
                        children: [
                          Text(
                            'Logout',
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary,),
                          ),
                          SizedBox(width: 4,),
                          Icon(Icons.logout,color: Theme.of(context).colorScheme.secondary,)
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // text
                        Text('Dark Mode',style:
                        TextStyle(fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary),),
                        // switch
                        CupertinoSwitch(
                            value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                            onChanged:(value){
                              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                            }
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            SetingTile()
          ],
        ),
      ),
    );
  }
}

