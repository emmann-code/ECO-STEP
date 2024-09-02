import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextfield({super.key,
    required this.controller, required this.hintText,
    required this.obscureText});

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),borderRadius: BorderRadius.circular(12),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 15
          ),
          // suffixIcon: IconButton(
          //   icon: Icon(
          //     widget.obscureText
          //         ? Icons.visibility
          //         : Icons.visibility_off,
          //   ),
          //   onPressed: _togglePasswordVisibility,
          // ),
        ),
      ),
    );
  }
}
