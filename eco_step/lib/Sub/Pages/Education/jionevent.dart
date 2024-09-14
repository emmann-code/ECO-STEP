import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinEventPage extends StatefulWidget {
  final Map<String, dynamic> event;

  const JoinEventPage({Key? key, required this.event}) : super(key: key);

  @override
  _JoinEventPageState createState() => _JoinEventPageState();
}

class _JoinEventPageState extends State<JoinEventPage> {
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

  Future<void> _submitEventJoin() async {
    if (!_isButtonEnabled) return;

    // Collect the data to send to Firestore
    final joinEventData = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'city': _cityController.text,
      'address': _addressController.text,
      'postcode': _postcodeController.text,
      'event': {
        'title': widget.event['title'],
        'date': widget.event['date'],
        'location': widget.event['location'], // Add location
        'details': widget.event['details'],   // Add details
        'image': widget.event['image'],       // Add image
      },
      'joinDate': Timestamp.now(),
    };

    // Save the join event data to Firestore
    await FirebaseFirestore.instance.collection('eventRegistrations').add(joinEventData);

    // Show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Event Joined"),
        content: Text("You've been added to the event list. We'll contact you via email for more details."),
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
          'Fill in the Form to Attend Event',
          style: GoogleFonts.roboto(
            fontSize: 17,
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
                Image.asset('${widget.event['image']}', height: 200), // Placeholder event image
                Text(
                  'Event: ${widget.event['title']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Event Date: ${widget.event['date']}',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Sponsored by: ${widget.event['organizer']}',
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
                    hintText: "City",
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
                  onPressed: _isButtonEnabled ? _submitEventJoin : null,
                  child: Text("Join Event"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
