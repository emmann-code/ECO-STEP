import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Pages/Profile/profile.dart';
import 'package:eco_step/Sub/Pages/MainScreen.dart';

class GoogleComponent extends StatefulWidget {
  const GoogleComponent({super.key});

  @override
  State<GoogleComponent> createState() => _GoogleComponentState();
}

class _GoogleComponentState extends State<GoogleComponent> {
  bool _isLoading = false;
  final FirebaseAuth _gauth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> _signInWithGoogle() async {
    try {
      print("Attempting Google sign-in...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google sign-in aborted by user.");
        return null; // The user canceled the sign-in
      }

      print("Google user obtained: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("Google authentication obtained.");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("AuthCredential created.");

      final UserCredential userCredential = await _gauth.signInWithCredential(credential);
      print("User signed in: ${userCredential.user?.email}");

      return userCredential.user;
    } catch (e) {
      print("Error during Google sign-in: $e");
      throw Exception('Failed to sign in with Google: ${e.toString()}');
    }
  }

  Future<void> _saveUserInfo(User user) async {
    try {
      DocumentReference userRef = _firestore.collection('users').doc(user.uid);

      await userRef.set({
        'uid': user.uid,
        'username': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'createdAt': Timestamp.now(),
        'lastSignIn': DateTime.now(),
      }, SetOptions(merge: true)); // Merge to avoid overwriting existing data

      print("User info saved to Firestore.");
    } catch (e) {
      print("Error saving user info to Firestore: $e");
      throw Exception('Failed to save user information to Firestore: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? SpinKitCircle(
        color: Theme.of(context).colorScheme.primary,
        size: 50.0,
      )
          : IconButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });

          // Start a timer to handle timeout
          bool timedOut = false;
          Future.delayed(Duration(minutes: 1), () {
            if (timedOut) return;
            if (_isLoading) {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sign-in timed out. Please try again.')),
              );
            }
          });

          try {
            final user = await _signInWithGoogle();
            if (user != null && context.mounted) {
              // Save user info to Firestore
              await _saveUserInfo(user);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(),
                ),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString()),
              ),
            );
          } finally {
            timedOut = true;
            setState(() {
              _isLoading = false;
            });
          }
        },
        icon: Image.asset("assets/google.png", scale: 2),
      ),
    );
  }
}
