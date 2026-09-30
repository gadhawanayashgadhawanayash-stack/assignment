import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> news = [
    {
      "title": "Flutter 3 Released",
      "description": "Flutter brings new features and improvements.",
      "image": "https://picsum.photos/seed/news1/300/200",
    },
    {
      "title": "New Technology Trends",
      "description": "Technology is changing rapidly around the world.",
      "image": "https://picsum.photos/seed/news2/300/200",
    },
    {
      "title": "AI in Modern Apps",
      "description":
          "Artificial intelligence is becoming common in applications.",
      "image": "https://picsum.photos/seed/news3/300/200",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("News Feed")),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: news.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 15),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Image.network(
                        news[index]["image"]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news[index]["title"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(news[index]["description"]!),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
