import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Image Cache App",
      home: ImageCacheScreen(),
    );
  }
}

class ImageCacheScreen extends StatefulWidget {
  @override
  State<ImageCacheScreen> createState() =>
      _ImageCacheScreenState();
}

class _ImageCacheScreenState extends State<ImageCacheScreen> {
  final String imageUrl =
      "https://picsum.photos/400/300";

  File? imageFile;
  bool isLoading = false;
  String message = "";

  Future<void> loadImage() async {
    setState(() {
      isLoading = true;
      message = "Loading image...";
    });

    try {
      final FileInfo? fileInfo =
    await DefaultCacheManager().getFileFromCache(imageUrl);

      File file;

      if (fileInfo != null) {
        // Image already exists in cache
        file = fileInfo.file;

        setState(() {
          message = "Image loaded from cache";
        });
      } else {
        // Download image and save it in cache
        file = await DefaultCacheManager().getSingleFile(imageUrl);

        setState(() {
          message = "Image downloaded and cached";
        });
      }

      setState(() {
        imageFile = file;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        message = "Error loading image";
      });
    }
  }

  Future<void> clearCache() async {
    await DefaultCacheManager().emptyCache();

    setState(() {
      imageFile = null;
      message = "Cache cleared";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Cache"),
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading)
                CircularProgressIndicator(),

              if (imageFile != null)
                Image.file(
                  imageFile!,
                  height: 250,
                  width: 350,
                  fit: BoxFit.cover,
                ),

              SizedBox(height: 20),

              Text(
                message,
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: loadImage,
                child: Text("Load Image"),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: clearCache,
                child: Text("Clear Cache"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}