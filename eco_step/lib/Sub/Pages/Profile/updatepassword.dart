import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Components/my_button.dart';
import '../../Components/my_profilepic.dart';
import '../../Components/my_textfield.dart';

class Updatepassword extends StatefulWidget {
  final String email;

  const Updatepassword({super.key, required this.email});

  @override
  State<Updatepassword> createState() => _UpdatepasswordState();
}

class _UpdatepasswordState extends State<Updatepassword> {
  final TextEditingController oldpassController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();
  final TextEditingController repeatnewpassController = TextEditingController();

  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
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

  Future<void> _updatePassword() async {
    try {
      String oldPassword = oldpassController.text;
      String newPassword = newpassController.text;
      String repeatNewPassword = repeatnewpassController.text;

      if (newPassword != repeatNewPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('New passwords do not match!')),
        );
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Re-authenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // Update the password
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password updated successfully!')),
        );

        // Optionally, you can update the Firestore as well
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.email)
            .update({'password': newPassword}); // Not recommended

        // Clear the input fields
        oldpassController.clear();
        newpassController.clear();
        repeatnewpassController.clear();

        // Optionally navigate back or stay on the page
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user signed in!')),
        );
      }
    } catch (e) {
      print('Failed to update password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update password: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Update Password",
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
              onImageSelected: (String imagePath) {},
              imageUrl: _profileImageUrl,
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Old Password:",
                style: GoogleFonts.aBeeZee(
                    fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: oldpassController,
              hintText: ".....",
              obscureText: true,
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "New Password:",
                style: GoogleFonts.aBeeZee(
                    fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: newpassController,
              hintText: ".....",
              obscureText: true,
            ),
            SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Repeat New Password:",
                style: GoogleFonts.aBeeZee(
                    fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            MyTextfield(
              controller: repeatnewpassController,
              hintText:".....",
              obscureText: true,
            ),
            SizedBox(height: 23),
            MyButton(
              text: "Save",
              onTap: _updatePassword, // Call the update password function
            ),
          ],
        ),
      ),
    );
  }
}
