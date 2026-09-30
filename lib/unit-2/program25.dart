import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavigationShell());
  }
}

class NavigationShell extends StatelessWidget {
  Widget navigationItems() {
    return Column(
      children: [
        ListTile(leading: Icon(Icons.home), title: Text("Home")),
        ListTile(leading: Icon(Icons.person), title: Text("Profile")),
        ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth >= 800;

        if (isDesktop) {
          return Scaffold(
            body: Row(
              children: [
                Container(
                  width: 220,
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Navigation",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      navigationItems(),
                    ],
                  ),
                ),

                Expanded(
                  child: Scaffold(
                    appBar: AppBar(title: Text("Desktop Dashboard")),
                    body: Center(
                      child: Text(
                        "Desktop Content",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text("Mobile Dashboard")),
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Text(
                        "Navigation Menu",
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  navigationItems(),
                ],
              ),
            ),
          ),
          body: Center(
            child: Text("Mobile Content", style: TextStyle(fontSize: 25)),
          ),
        );
      },
    );
  }
}
