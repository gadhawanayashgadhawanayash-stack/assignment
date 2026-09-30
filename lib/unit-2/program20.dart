import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> images = [
    "https://picsum.photos/seed/media1/800/450",
    "https://picsum.photos/seed/media2/800/450",
    "https://picsum.photos/seed/media3/800/450",
    "https://picsum.photos/seed/media4/800/450",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Media Cards")),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 15),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      images[index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Media Item ${index + 1}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
