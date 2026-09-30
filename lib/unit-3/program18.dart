import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class CartModel extends ChangeNotifier {
  List<Map<String, dynamic>> cartItems = [];

  void addItem(String name, double price) {
    cartItems.add({
      "name": name,
      "price": price,
    });

    notifyListeners();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (var item in cartItems) {
      total += item["price"];
    }

    return total;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCartScreen(),
    );
  }
}

class ShoppingCartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Laptop",
      "price": 50000.0,
    },
    {
      "name": "Mobile",
      "price": 25000.0,
    },
    {
      "name": "Headphones",
      "price": 2000.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index]["name"]),
                  subtitle: Text(
                    "₹${products[index]["price"]}",
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      context.read<CartModel>().addItem(
                        products[index]["name"],
                        products[index]["price"],
                      );
                    },
                    child: Text("Add"),
                  ),
                );
              },
            ),
          ),

          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Cart Items: ${cart.cartItems.length}",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Total: ₹${cart.totalPrice}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    if (cart.cartItems.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: cart.cartItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                cart.cartItems[index]["name"],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  cart.removeItem(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}