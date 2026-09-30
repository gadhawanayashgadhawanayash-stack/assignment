import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProductDetailScreen());
  }
}

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    "https://picsum.photos/seed/product/800/500",
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),

                  Positioned(
                    top: 15,
                    left: 15,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.red,
                      child: Text(
                        "30% OFF",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Text(
                "Premium Headphones",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text("Wireless")),
                  Chip(label: Text("Bluetooth")),
                  Chip(label: Text("Premium")),
                  Chip(label: Text("Noise Cancelling")),
                ],
              ),

              SizedBox(height: 20),

              Text(
                "High-quality wireless headphones with excellent "
                "sound quality and comfortable design.",
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      "₹2,999",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  Flexible(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print("Added to cart");
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text("Add to Cart"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
