import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_step/Sub/Pages/BenefitShop/shop_product.dart';
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

  @override
  void initState() {
    super.initState();
    _getEcoPoints(); // Fetch eco points from Firebase
  }


  int ecoPoints = 0; // Eco points initialized to 0

  // Function to fetch eco points from Firestore
  void _getEcoPoints() async {
    try {
      String userId = 'user-id'; // Replace with the actual user ID from your auth
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      // Cast the snapshot data to Map<String, dynamic>
      setState(() {
        ecoPoints = (snapshot.data() as Map<String, dynamic>)['ecoPoints'] ?? 0; // Get the ecoPoints or default to 0
      });
    } catch (e) {
      print("Error fetching eco points: $e");
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
                      // No action needed here
                    },
                    imageUrl: _profileImageUrl,  // Pass the image URL
                    showCameraIcon: false,  // Ensure the camera icon is not shown
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hi, ${username ?? 'User'}!',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
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
