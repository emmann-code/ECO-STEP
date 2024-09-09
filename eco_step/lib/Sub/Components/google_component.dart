// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import Spinkit
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../Pages/Profile/profile.dart';
//
// class GoogleComponent extends StatefulWidget {
//   const GoogleComponent({super.key});
//
//   @override
//   State<GoogleComponent> createState() => _GoogleComponentState();
// }
//
// class _GoogleComponentState extends State<GoogleComponent> {
//   bool _isLoading = false;
//   final FirebaseAuth _gauth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   Future<User?> _signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         return null; // The user canceled the sign-in
//       }
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       final UserCredential userCredential = await _gauth.signInWithCredential(credential);
//       return userCredential.user;
//     } catch (e) {
//       throw Exception('Failed to sign in with Google: ${e.toString()}');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _isLoading
//           ? SpinKitCircle(
//         color: Theme.of(context).colorScheme.primary,
//         size: 50.0,
//       )
//           : IconButton(
//         onPressed: () async {
//           setState(() {
//             _isLoading = true;
//           });
//
//           try {
//             final user = await _signInWithGoogle();
//             if (user != null && context.mounted) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ProfilePage(email: user.displayName!),
//                 ),
//               );
//             }
//           } catch (e) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(e.toString()),
//               ),
//             );
//           } finally {
//             // Stop loading after 1 minute if sign-in fails
//             Future.delayed(Duration(minutes: 1), () {
//               if (_isLoading) {
//                 setState(() {
//                   _isLoading = false;
//                 });
//               }
//             });
//           }
//         },
//         icon: Image.asset("assets/google.png", scale: 2),
//       ),
//     );
//   }
// }
import 'package:eco_step/Sub/Pages/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
