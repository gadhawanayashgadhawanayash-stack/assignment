import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageCopyScreen(),
    );
  }
}

class ImageCopyScreen extends StatefulWidget {
  @override
  State<ImageCopyScreen> createState() => _ImageCopyScreenState();
}

class _ImageCopyScreenState extends State<ImageCopyScreen> {
  File? selectedImage;
  String message = "";

  Future<void> pickAndCopyImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      return;
    }

    final directory = await getApplicationDocumentsDirectory();

    final fileName = image.name;

    final destinationPath = '${directory.path}/$fileName';

    final copiedFile = await File(image.path).copy(destinationPath);

    setState(() {
      selectedImage = copiedFile;
      message = "Image copied successfully!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Copy Image"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (selectedImage != null)
                Image.file(
                  selectedImage!,
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: pickAndCopyImage,
                child: Text("Pick Image from Gallery"),
              ),

              SizedBox(height: 20),

              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}