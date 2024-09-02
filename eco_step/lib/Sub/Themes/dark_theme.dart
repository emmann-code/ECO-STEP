import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    background: Color(0xFF1D212A), // Overall background
    primary: Color(0xFFFFFFFF), // Text color (white)
    secondary: Color(0xFF797979), // Card and background areas (gray)
    tertiary: Color(0xFF2E2E2E), // Input fields and borders (dark gray)
    inversePrimary: Color(0xFF217074), // Icon colors (teal green)
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF121212), // AppBar background (very dark gray)
    iconTheme: IconThemeData(color: Color(0xFFFFFFFF)), // Icons (white)
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF38745B), // Buttons (deep green)
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.all(Color(0xFF76C893)), // Checkbox eco-green
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // Default text (white)
    bodyMedium: TextStyle(color: Color(0xFF797979)), // Secondary text (gray)
    headlineSmall: TextStyle(color: Color(0xFF217074), fontWeight: FontWeight.bold), // Title text (teal green)
  ),
  iconTheme: IconThemeData(color: Color(0xFF217074)), // Icon colors (teal green)
);
