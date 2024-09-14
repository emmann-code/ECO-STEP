import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Pages/BenefitShop/shop_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Components/my_profilepic.dart';
import '../../Models/product_items.dart';
class BenefitShop extends StatefulWidget {
  final String email;

  const BenefitShop({super.key, required this.email});

  @override
  State<BenefitShop> createState() => _BenefitShopState();
}

class _BenefitShopState extends State<BenefitShop> {
  String? _profileImageUrl;  // This will store the profile image URL
  String? username;
  int ecoPoints = 0; // Eco points initialized to 0

  @override
  void initState() {
    super.initState();
    _getEcoPoints(); // Fetch eco points from Firebase
    loadUserProfile();
  }

  // Function to fetch eco points from Firestore
  Future<int> _getEcoPoints() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        print("User is not logged in");
        return 0;
      }
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data()?['ecoPoints'] ?? 0;
      } else {
        print("User document not found");
        return 0;
      }
    } catch (e) {
      print("Error fetching eco points: $e");
      return 0;
    }
  }

  Future<void> loadUserProfile() async {
    try {
      // Fetch the user profile document from Firestore
      DocumentSnapshot<Map<String, dynamic>> userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (userProfile.exists) {
        // Check and handle the "profileImage" field
        String? profileImageUrl;
        if (userProfile.data()!.containsKey('profileImage')) {
          profileImageUrl = userProfile.data()!['profileImage'];
        } else {
          print('Profile image not set');
        }

        // Check and handle the "name" field
        String username = userProfile.data()!['username'] ?? 'No name set';

        setState(() {
          _profileImageUrl = profileImageUrl;
          this.username = username;
        });

      } else {
        print('User profile does not exist');
      }
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
          'Benefit Shop',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      // Update the profile image URL and reload the profile
                      setState(() {
                        _profileImageUrl = imagePath;
                      });
                      loadUserProfile();
                    },
                    imageUrl: _profileImageUrl,  // Pass the image URL
                    showCameraIcon: false,  // Ensure the camera icon is not shown
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hi, ${username ?? 'User'}!',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
                                      '$ecoPoints Eco-Points',
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
              SizedBox(height: 20), // Add some spacing before the product grid
              Text(
                "Available Products",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,  // Two items per row
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: MyProducts.allProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: MyProducts.allProducts[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}