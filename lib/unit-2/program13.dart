import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "name": "Laptop",
      "price": "₹50,000",
      "image": "https://picsum.photos/seed/laptop/300/200",
    },
    {
      "name": "Mobile",
      "price": "₹25,000",
      "image": "https://picsum.photos/seed/mobile/300/200",
    },
    {
      "name": "Headphones",
      "price": "₹2,000",
      "image": "https://picsum.photos/seed/headphones/300/200",
    },
    {
      "name": "Smart Watch",
      "price": "₹5,000",
      "image": "https://picsum.photos/seed/watch/300/200",
    },
    {
      "name": "Camera",
      "price": "₹40,000",
      "image": "https://picsum.photos/seed/camera/300/200",
    },
    {
      "name": "Speaker",
      "price": "₹3,000",
      "image": "https://picsum.photos/seed/speaker/300/200",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Product Listing")),
        body: GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      products[index]["image"]!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      products[index]["name"]!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Text(
                      products[index]["price"]!,
                      style: TextStyle(fontSize: 16, color: Colors.green),
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
