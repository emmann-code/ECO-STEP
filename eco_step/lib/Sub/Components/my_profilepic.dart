import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profilepic extends StatefulWidget {
  final Function(String) onImageSelected;
  final String? imageUrl;
  final bool showCameraIcon;

  const Profilepic({
    super.key,
    required this.onImageSelected,
    this.imageUrl,
    this.showCameraIcon = false,
  });

  @override
  State<Profilepic> createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imageUrl;  // Use the provided imageUrl if available
  }

  Future<void> _pickImage(ImageSource  source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      await _uploadImage();
      widget.onImageSelected(_imagePath!);
    }
  }


  Future<String?> _uploadImage() async {
    if (_imagePath == null) return null;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      String uid = user.uid;
      Reference storageRef =
      FirebaseStorage.instance.ref().child('profile_images').child(uid);
      UploadTask uploadTask = storageRef.putFile(_imagePath! as File);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Update Firestore with the new image URL
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'profileImage': downloadUrl,
      });

      setState(() {
        _imagePath = downloadUrl;
      });

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: _imagePath != null
                  ? FileImage(File(_imagePath!))
                  : widget.imageUrl != null
                  ? NetworkImage(widget.imageUrl!) as ImageProvider
                  : const AssetImage('assets/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (widget.showCameraIcon)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.camera_alt,
                    size: 20,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}