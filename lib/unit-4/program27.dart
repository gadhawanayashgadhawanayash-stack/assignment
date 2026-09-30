import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SyncScreen extends StatefulWidget {
  @override
  State<SyncScreen> createState() => _SyncScreenState();
}

class _SyncScreenState extends State<SyncScreen> {
  List<Map<String, dynamic>> records = [];

  String connectionStatus = "Checking...";

  @override
  void initState() {
    super.initState();

    loadRecords();
    checkConnection();
    listenToConnectivity();
  }

  Future<void> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();

    final String? data = prefs.getString('offline_records');

    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);

      setState(() {
        records = decoded
            .map(
              (item) =>
          Map<String, dynamic>.from(item),
        )
            .toList();
      });
    }
  }

  Future<void> saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'offline_records',
      jsonEncode(records),
    );
  }

  Future<void> checkConnection() async {
    final result =
    await Connectivity().checkConnectivity();

    if (result.contains(ConnectivityResult.none)) {
      setState(() {
        connectionStatus = "Offline";
      });
    } else {
      setState(() {
        connectionStatus = "Online";
      });

      await syncRecords();
    }
  }

  void listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen(
          (List<ConnectivityResult> results) async {
        if (results.contains(ConnectivityResult.none)) {
          setState(() {
            connectionStatus = "Offline";
          });
        } else {
          setState(() {
            connectionStatus = "Online";
          });

          await syncRecords();
        }
      },
    );
  }

  Future<void> addRecord() async {
    final record = {
      'name': 'Yash',
      'message': 'Offline record',
      'synced': false,
    };

    setState(() {
      records.add(record);
    });

    await saveRecords();

    if (connectionStatus == "Online") {
      await syncRecords();
    }
  }

  Future<void> syncRecords() async {
    if (connectionStatus != "Online") {
      return;
    }

    for (int i = 0; i < records.length; i++) {
      if (records[i]['synced'] == false) {
        try {
          final response = await http.post(
            Uri.parse(
              'https://jsonplaceholder.typicode.com/posts',
            ),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'name': records[i]['name'],
              'message': records[i]['message'],
            }),
          );

          if (response.statusCode == 201) {
            records[i]['synced'] = true;
          }
        } catch (e) {
          print("Sync failed: $e");
        }
      }
    }

    await saveRecords();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Background Sync"),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),

          Text(
            "Connection: $connectionStatus",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: addRecord,
            child: Text("Add Offline Record"),
          ),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: syncRecords,
            child: Text("Sync Now"),
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];

                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(record['name']),
                    subtitle: Text(record['message']),
                    trailing: Icon(
                      record['synced'] == true
                          ? Icons.cloud_done
                          : Icons.cloud_off,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SyncScreen(),
    ),
  );
}