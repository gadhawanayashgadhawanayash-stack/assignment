import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final VoidCallback onTap;

  ProfileCard({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(role),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Profile Cards")),
        body: Column(
          children: [
            ProfileCard(
              name: "Yash",
              role: "Flutter Developer",
              imageUrl: "https://picsum.photos/seed/yash/200",
              onTap: () {
                print("Yash profile clicked");
              },
            ),
            ProfileCard(
              name: "Rahul",
              role: "Web Developer",
              imageUrl: "https://picsum.photos/seed/rahul/200",
              onTap: () {
                print("Rahul profile clicked");
              },
            ),
            ProfileCard(
              name: "Amit",
              role: "UI Designer",
              imageUrl: "https://picsum.photos/seed/amit/200",
              onTap: () {
                print("Amit profile clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}
