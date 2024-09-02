import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Components/my_button.dart';
import 'package:eco_step/Sub/Components/my_profilepic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Components/my_textfield.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String? _imagePath;

  Future<void> _saveProfile() async {
    try {
      print('Saving profile...');
      String? imageUrl;
      if (_imagePath != null) {
        // Log the image path
        print('Image path: $_imagePath');

        // Upload the image to Firebase Storage
        File file = File(_imagePath!);
        String fileName = 'profile_${emailController.text}.png';

        // Try uploading the file with a retry mechanism
        for (int attempt = 0; attempt < 3; attempt++) {
          try {
            TaskSnapshot snapshot = await FirebaseStorage.instance
                .ref()
                .child('profile_images/$fileName')
                .putFile(file);

            imageUrl = await snapshot.ref.getDownloadURL();
            print('Image uploaded: $imageUrl');
            break; // Exit the loop on successful upload
          } catch (e) {
            if (attempt == 2) {
              throw e; // Re-throw the error after the last attempt
            }
            print('Upload failed, retrying... (Attempt ${attempt + 1}/3)');
            await Future.delayed(Duration(seconds: 2)); // Delay before retry
          }
        }
      }

      // Save user information to Firestore
      await FirebaseFirestore.instance.collection('users').doc(emailController.text).set({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'city': cityController.text,
        if (imageUrl != null) 'profileImage': imageUrl,
      });

      print('Profile updated successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    } catch (e) {
      print('Failed to update profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Edit Personal Information",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Profilepic(
              onImageSelected: (String imagePath) {
                _imagePath = imagePath;
              },
              showCameraIcon: true,  // Show the camera icon
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Full Name:",
                style: GoogleFonts.aBeeZee(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: nameController,
              hintText: "John Micheal",
              obscureText: false,
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Phone:",
                style: GoogleFonts.aBeeZee(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: phoneController,
              hintText: "+2345 989",
              obscureText: false,
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Email:",
                style: GoogleFonts.aBeeZee(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: emailController,
              hintText: "email@gmail.com",
              obscureText: false,
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Country/city:",
                style: GoogleFonts.aBeeZee(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: cityController,
              hintText: "Lagos City",
              obscureText: false,
            ),
            SizedBox(height: 23),
            MyButton(
              text: "Save",
              onTap: _saveProfile, // Trigger the save profile function
            ),
          ],
        ),
      ),
    );
  }
}
