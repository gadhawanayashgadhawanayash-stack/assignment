import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProfileScreen());
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [
          SizedBox(
            height: 280,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  "https://picsum.photos/seed/banner/800/300",
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/seed/profile/300/300",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15),

          Text(
            "Yash",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 5),

          Text("Flutter Developer", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
