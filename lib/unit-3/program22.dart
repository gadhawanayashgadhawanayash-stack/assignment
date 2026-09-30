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
  final List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  double get total {
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
      home: ProductScreen(),
    );
  }
}

// Product List
class ProductScreen extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Laptop",
      "price": 50000.0,
      "icon": Icons.laptop,
    },
    {
      "name": "Mobile",
      "price": 25000.0,
      "icon": Icons.phone_android,
    },
    {
      "name": "Headphones",
      "price": 2000.0,
      "icon": Icons.headphones,
    },
    {
      "name": "Smart Watch",
      "price": 5000.0,
      "icon": Icons.watch,
    },
    {
      "name": "Camera",
      "price": 40000.0,
      "icon": Icons.camera_alt,
    },
    {
      "name": "Speaker",
      "price": 3000.0,
      "icon": Icons.speaker,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce App"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: GridView.builder(
        padding: EdgeInsets.all(10),

        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),

        itemCount: products.length,

        itemBuilder: (context, index) {
          final product = products[index];

          return Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(10),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    product["icon"],
                    size: 60,
                  ),

                  SizedBox(height: 10),

                  Text(
                    product["name"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "₹${product["price"]}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<CartModel>()
                          .addToCart(product);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            "${product["name"]} added to cart",
                          ),
                        ),
                      );
                    },
                    child: Text("Add to Cart"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Cart Screen
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),

      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          if (cart.cartItems.isEmpty) {
            return Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 22),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,

                  itemBuilder: (context, index) {
                    final item = cart.cartItems[index];

                    return ListTile(
                      leading: Icon(Icons.shopping_bag),

                      title: Text(item["name"]),

                      subtitle: Text(
                        "₹${item["price"]}",
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.delete),

                        onPressed: () {
                          cart.removeFromCart(index);
                        },
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),

                child: Column(
                  children: [
                    Text(
                      "Total: ₹${cart.total}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CheckoutScreen(
                                  total: cart.total,
                                  itemCount:
                                  cart.cartItems.length,
                                ),
                          ),
                        );
                      },
                      child: Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Checkout Summary
class CheckoutScreen extends StatelessWidget {
  final double total;
  final int itemCount;

  CheckoutScreen({
    required this.total,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout Summary"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              Icons.check_circle,
              size: 80,
            ),

            SizedBox(height: 20),

            Text(
              "Order Summary",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            Text(
              "Total Items: $itemCount",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 10),

            Text(
              "Total Amount: ₹$total",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Order Placed Successfully!",
                    ),
                  ),
                );
              },
              child: Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}