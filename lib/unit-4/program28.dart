import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "File Logger",
      home: LoggerScreen(),
    );
  }
}

class LoggerScreen extends StatefulWidget {
  @override
  State<LoggerScreen> createState() => _LoggerScreenState();
}

class _LoggerScreenState extends State<LoggerScreen> {
  final TextEditingController logController =
  TextEditingController();

  String logContent = "";

  Future<File> getLogFile() async {
    final directory =
    await getApplicationDocumentsDirectory();

    return File('${directory.path}/app_log.txt');
  }

  // Add timestamped log
  Future<void> addLog() async {
    if (logController.text.isEmpty) {
      return;
    }

    final file = await getLogFile();

    final timestamp = DateTime.now().toString();

    final logEntry =
        "[$timestamp] ${logController.text}\n";

    await file.writeAsString(
      logEntry,
      mode: FileMode.append,
    );

    logController.clear();

    await loadLogs();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Log added successfully"),
      ),
    );
  }

  // Read logs
  Future<void> loadLogs() async {
    final file = await getLogFile();

    if (await file.exists()) {
      final content = await file.readAsString();

      setState(() {
        logContent = content;
      });
    }
  }

  // Share log file
  Future<void> shareLogFile() async {
    final file = await getLogFile();

    if (await file.exists()) {
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile(file.path),
          ],
          text: "Application Log File",
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Log file does not exist"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    loadLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("File Logging System"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: logController,
              decoration: InputDecoration(
                labelText: "Enter log message",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: addLog,
                  child: Text("Add Log"),
                ),

                ElevatedButton(
                  onPressed: shareLogFile,
                  child: Text("Share Log File"),
                ),
              ],
            ),

            SizedBox(height: 20),

            Text(
              "Log Entries",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    logContent.isEmpty
                        ? "No logs available"
                        : logContent,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}