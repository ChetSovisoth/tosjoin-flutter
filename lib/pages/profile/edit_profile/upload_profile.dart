import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add the image_picker dependency to your pubspec.yaml

class UploadProfileImagePage extends StatefulWidget {
  const UploadProfileImagePage({super.key});

  @override
  _UploadProfileImagePageState createState() => _UploadProfileImagePageState();
}

class _UploadProfileImagePageState extends State<UploadProfileImagePage> {
  XFile? _image; // This will hold the selected image

  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery); // Or use ImageSource.camera for camera
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Profile Image",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
            ),
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/assets/profile.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text("No image selected")
                : Image.file(
                    File(_image!.path),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can handle saving the profile image here
                Navigator.pop(context); // Close the page after uploading
              },
              child: const Text("Save Image"),
            ),
          ],
        ),
      ),
    );
  }
}
