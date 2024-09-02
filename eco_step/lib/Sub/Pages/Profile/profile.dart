import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Components/my_profileContainer.dart';
import 'package:eco_step/Sub/Components/my_profilepic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _profileImageUrl;  // This will store the profile image URL
  String? _userName;

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
        _userName = userDoc['name'] ?? 'User';
      });
    } catch (e) {
      print('Failed to load user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Profilepic(
                  onImageSelected: (String imagePath) {
                    // No action needed here
                  },
                  imageUrl: _profileImageUrl,  // Pass the image URL
                  showCameraIcon: false,  // Ensure the camera icon is not shown
                ),
                SizedBox(width: 10),
                Text(
                  'Hi, ${_userName ?? 'User'}!',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // color: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Image(image: AssetImage('assets/ecopoints.png')),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.eco, color: Colors.green, size: 16),
                                  SizedBox(width: 5),
                                  Text(
                                    '890 Eco-Points',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'View accrual history',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ProfileContainer(),
          ],
        ),
      ),
    );
  }
}



// import 'package:eco_step/Sub/Components/my_profileContainer.dart';
// import 'package:eco_step/Sub/Components/my_profilepic.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../Components/my_bottomnav.dart';
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key, required String username});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
// class _ProfilePageState extends State<ProfilePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: Text('Profile',
//           style: GoogleFonts.roboto(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,),
//         ),
//         backgroundColor: Theme.of(context).colorScheme.background,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                Profilepic(onImageSelected: (String ) {  },),
//                 SizedBox(width: 10),
//                 Text(
//                   'Hi, John Michael!',
//                     style: GoogleFonts.roboto(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       // color: Colors.black
//                     )
//                 ),
//               ],
//             ),
//             SizedBox(height: 10,),
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Stack(
//                 children: [
//                   Image(image: AssetImage('assets/ecopoints.png')),
//                   Padding(padding: EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.eco, color: Colors.green, size: 16),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   '890 Eco-Points',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Text(
//                         'View accrual history',
//                         style: TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ],
//                   ),)
//                 ],
//               )
//             ),
//             SizedBox(height: 20),
//             ProfileContainer()
//           ],
//         ),
//       ),
//     );
//   }
// }