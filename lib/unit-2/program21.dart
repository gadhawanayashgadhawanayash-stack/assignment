import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<String> items = [
    "Sales",
    "Orders",
    "Customers",
    "Products",
    "Revenue",
    "Reports",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Responsive Dashboard")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Mobile
          if (screenWidth < 600) {
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text(items[index]),
                  ),
                );
              },
            );
          }
          // Tablet
          else if (screenWidth < 1000) {
            return GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Center(
                    child: Text(items[index], style: TextStyle(fontSize: 20)),
                  ),
                );
              },
            );
          }
          // Desktop
          else {
            return Row(
              children: [
                Container(
                  width: 220,
                  color: Colors.blueGrey,
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "Sidebar",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      ListTile(
                        leading: Icon(Icons.home, color: Colors.white),
                        title: Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white),
                        title: Text(
                          "Settings",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Text(
                        "Main Content",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 250,
                  padding: EdgeInsets.all(20),
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Text(
                      "Details Panel",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
