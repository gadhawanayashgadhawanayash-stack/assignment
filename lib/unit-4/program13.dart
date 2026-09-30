import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StringListScreen(),
    );
  }
}

class StringListScreen extends StatefulWidget {
  @override
  State<StringListScreen> createState() =>
      _StringListScreenState();
}

class _StringListScreenState extends State<StringListScreen> {
  final TextEditingController itemController =
  TextEditingController();

  List<String> items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();

    final savedItems =
        prefs.getStringList("items") ?? [];

    setState(() {
      items = savedItems;
    });
  }

  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("items", items);
  }

  void addItem() {
    if (itemController.text.isNotEmpty) {
      setState(() {
        items.add(itemController.text);
        itemController.clear();
      });

      saveItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved String List"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: itemController,
                    decoration: InputDecoration(
                      labelText: "Enter item",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addItem,
                  child: Text("Add"),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.list),
                  title: Text(items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}