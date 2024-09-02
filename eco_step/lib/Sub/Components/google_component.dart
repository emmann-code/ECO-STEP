import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Pages/Profile/profile.dart';
class GoogleComponent extends StatefulWidget {
  const GoogleComponent({super.key});

  @override
  State<GoogleComponent> createState() => _GoogleComponentState();
}

class _GoogleComponentState extends State<GoogleComponent> {
  bool _isLoading = false;

  final FirebaseAuth _gauth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
    await _gauth.signInWithCredential(credential);
    final User? user = userCredential.user;
    return null;

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          try {
            final user = await _signInWithGoogle();
            setState(() {
              _isLoading = false;
            });
            if (user != null && context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfilePage(email: user.displayName!,),
                ),
              );
            }
          } catch (e) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to sign in with Google: ${e.toString()}'),
              ),
            );
          }
        },
        icon: Image.asset("assets/google.png",scale: 2,),
      ),
    );
  }
}
