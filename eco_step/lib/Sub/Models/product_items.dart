import 'package:eco_step/Sub/Models/shop_model.dart';
import 'package:flutter/material.dart';

class MyProducts {
  static List<Product> allProducts = [
    Product(
      id: 1,
      name: 'Notebook',
      category: 'Size A5',
      image: 'assets/notebook.png',
      size: 'Size A5',
      color: 'White',
      material: 'Paper',
      maxLoad: 0.5, // Not applicable for this item
      price: 400,
      quantity: 1,
      // pointsRequired: 50,
    ),
    Product(
      id: 2,
      name: 'Shopper',
      category: 'Size 35*65 sm',
      image: 'assets/foam.png',
      size: '35*65 sm',
      color: 'Black',
      material: '100% Cotton',
      maxLoad: 3.0,
      price: 550,
      quantity: 1,
      // pointsRequired: 75,
    ),
    Product(
      id: 3,
      name: 'T-Shirt',
      category: 'Size M',
      image: 'assets/texile.png',
      size: 'M,L,XL',
      color: 'Blue',
      material: '100% Cotton',
      maxLoad: 0.2, // Not applicable
      price: 600,
      quantity: 1,
      // pointsRequired: 100,
    ),
    Product(
      id: 4,
      name: 'Mug',
      category: 'Standard',
      image: 'assets/ceramic.png',
      size: 'Standard',
      color: 'White',
      material: 'Ceramic',
      maxLoad: 0.4, // Max load in kg
      price: 300,
      quantity: 1,
      // pointsRequired: 30,
    ),
    Product(
      id: 5,
      name: 'Table',
      category: 'Wooden',
      image: 'assets/wood.png',
      size: 'Medium',
      color: 'Brown',
      material: 'Wood',
      maxLoad: 50.0, // Max load in kg
      price: 1000,
      quantity: 1,
      // pointsRequired: 500,
    ),
    Product(
      id: 6,
      name: 'Bag',
      category: 'Leather',
      image: 'assets/food.png',
      size: 'Medium',
      color: 'Brown',
      material: 'Wood',
      maxLoad: 50.0, // Max load in kg
      price: 1500,
      quantity: 1,
      // pointsRequired: 500,
    ),
    // Add more products as needed
  ];
}
