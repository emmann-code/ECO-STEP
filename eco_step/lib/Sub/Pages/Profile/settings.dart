import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Components/my_settingTile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/my_profilepic.dart';
import '../../Services/auth/auth_service.dart';
import '../../Services/auth/login_or_register.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  String? get email => email;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  String? _profileImageUrl;  // This will store the profile image URL


  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      // Fetch the user's profile data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.email)
          .get();

      setState(() {
        _profileImageUrl = userDoc['profileImage'];
      });
    } catch (e) {
      print('Failed to load user profile: $e');
    }
  }

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Profilepic(
                  onImageSelected: (String imagePath) {
                    // You can use this to allow updating the image from here as well
                  },
                  imageUrl: _profileImageUrl,  // Pass the image URL here
                ),
                SizedBox(width: 150),
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

