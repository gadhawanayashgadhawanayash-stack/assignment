import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('todoBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Offline To-Do",
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController taskController =
  TextEditingController();

  late Box todoBox;

  String connectionStatus = "Checking...";

  @override
  void initState() {
    super.initState();

    todoBox = Hive.box('todoBox');

    checkConnection();

    Connectivity().onConnectivityChanged.listen(
          (List<ConnectivityResult> results) {
        if (results.contains(ConnectivityResult.none)) {
          setState(() {
            connectionStatus = "Offline";
          });
        } else {
          setState(() {
            connectionStatus = "Online";
          });

          syncTasks();
        }
      },
    );
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      setState(() {
        connectionStatus = "Offline";
      });
    } else {
      setState(() {
        connectionStatus = "Online";
      });

      syncTasks();
    }
  }

  Future<void> addTask() async {
    if (taskController.text.isEmpty) {
      return;
    }

    final task = {
      'title': taskController.text,
      'synced': false,
    };

    await todoBox.add(task);

    taskController.clear();

    setState(() {});

    if (connectionStatus == "Online") {
      await syncTasks();
    }
  }

  Future<void> syncTasks() async {
    if (connectionStatus != "Online") {
      return;
    }

    for (int i = 0; i < todoBox.length; i++) {
      final task = Map<String, dynamic>.from(
        todoBox.getAt(i),
      );

      if (task['synced'] == false) {
        try {
          final response = await http.post(
            Uri.parse(
              'https://jsonplaceholder.typicode.com/todos',
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'title': task['title'],
              'completed': false,
            }),
          );

          if (response.statusCode == 201) {
            task['synced'] = true;

            await todoBox.putAt(i, task);
          }
        } catch (e) {
          print("Sync failed");
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Offline To-Do"),
      ),

      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Text(
              "Status: $connectionStatus",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: "Enter task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: addTask,
                  child: Text("Add"),
                ),
              ],
            ),
          ),

          Expanded(
            child: ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, box, child) {
                if (box.isEmpty) {
                  return Center(
                    child: Text(
                      "No Tasks",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final task = Map<String, dynamic>.from(
                      box.getAt(index),
                    );

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(task['title']),
                        trailing: Icon(
                          task['synced'] == true
                              ? Icons.cloud_done
                              : Icons.cloud_off,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}