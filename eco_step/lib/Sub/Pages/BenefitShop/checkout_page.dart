import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Models/shop_model.dart';

class CheckoutPage extends StatefulWidget {
  final Product product;

  const CheckoutPage({Key? key, required this.product}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();

  void _validateInputs() {
    setState(() {
      _isButtonEnabled = _formKey.currentState!.validate();
    });
  }

  Future<void> _submitOrder() async {
    if (!_isButtonEnabled) return;

    // Collect the data to send to Firestore
    final orderData = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'city': _cityController.text,
      'address': _addressController.text,
      'postcode': _postcodeController.text,
      'product': {
        'name': widget.product.name,
        'size': widget.product.size,
        'color': widget.product.color,
        'material': widget.product.material,
        'maxLoad': widget.product.maxLoad,
        'image': widget.product.image,
      },
      'orderDate': Timestamp.now(),
    };

    // Save the order data to Firestore
    await FirebaseFirestore.instance.collection('orders').add(orderData);

    // Show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Received"),
        content: Text("We'll be sending you a package shortly."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
            child: Text("Thank you"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.product.name,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            onChanged: _validateInputs,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(widget.product.image, height: 200),
                Text(
                  'Size: ${widget.product.size}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Color: ${widget.product.color}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Material: ${widget.product.material}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Max load: ${widget.product.maxLoad} kg',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Full name",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Phone number",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15),
                  ),
                  validator: (value) => value!.isEmpty
                      ? 'Please enter your phone number'
                      : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Country/city",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your city' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Address",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your address' : null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _postcodeController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Postcode",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 15),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your postcode' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isButtonEnabled ? _submitOrder : null,
                  child: Text("Checkout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
