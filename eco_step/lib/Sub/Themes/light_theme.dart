import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: Color(0xFFF6F6F6), // Light background (off-white)
    primary: Color(0xFF217074), // Text color (teal green)
    secondary: Color(0xFFFFFFFF), // Card and background areas (white)
    tertiary: Color(0xFFD8D9E1), // Input fields and borders (light gray)
    inversePrimary: Color(0xFF38745B), // Icon colors (deep green)
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF5F5F5), // AppBar background (off-white)
    iconTheme: IconThemeData(color: Color(0xFF217074)), // Icons (teal green)
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF38745B), // Buttons (deep green)
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(Color(0xFF217074)), // Checkbox (teal green)
  ),
  // textTheme: TextTheme(
  //   bodyLarge: TextStyle(color: Color(0xFF121212)), // Default text (teal green)
  //   bodyMedium: TextStyle(color: Color(0xFF4CAF50)), // Secondary text (light green)
  //   headlineSmall: TextStyle(color: Color(0xFF1B5E20), fontWeight: FontWeight.bold), // Title text (deep forest green)
  // ),
  iconTheme: IconThemeData(color: Color(0xFF38745B)), // Icon colors (deep green)
);
//0xFF217074
//0xFF4CAF50