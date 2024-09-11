import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profilepic extends StatefulWidget {
  final Function(String) onImageSelected;
  final String? imageUrl;
  final bool showCameraIcon;  // Add this parameter

  const Profilepic({
    super.key,
    required this.onImageSelected,
    this.imageUrl,
    this.showCameraIcon = false,  // Default to false if not provided
  });

  @override
  State<Profilepic> createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imageUrl;  // Set the initial image path to the URL
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,preferredCameraDevice: CameraDevice.front);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });

      widget.onImageSelected(_imagePath!);
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
                  : AssetImage('assets/profile.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (widget.showCameraIcon)  // Conditionally show the camera icon
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
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
