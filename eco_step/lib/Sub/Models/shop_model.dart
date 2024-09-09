import 'package:flutter/material.dart';
class Product {
  final int id;
  final String name;
  final String category;
  final String image;
  final String size;
  final String color;
  final String material;
  final double maxLoad;
  final int price;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.size,
    required this.color,
    required this.material,
    required this.maxLoad,
    required this.price,
    required this.quantity,
  });
}
