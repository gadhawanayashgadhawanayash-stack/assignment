import 'package:flutter/material.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
Widget settingsTable(String title, List<List<String>> data) {
return Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
title,
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
),
),
SizedBox(height: 10),
Table(
border: TableBorder.all(
color: Colors.grey,
),
children: data.map((row) {
return TableRow(
children: row.map((value) {
return Padding(
padding: EdgeInsets.all(10),
child: Text(value),
);
}).toList(),
);
}).toList(),
),
],
);
}

@override
Widget build(BuildContext context) {
return MaterialApp(
home: Scaffold(
appBar: AppBar(
title: Text("Settings"),
),
body: LayoutBuilder(
builder: (context, constraints) {
bool isWide = constraints.maxWidth > 700;

List<Widget> sections = [
settingsTable(
"Account",
[
["Username", "Yash"],
["Email", "yash@example.com"],
["Status", "Active"],
],
),
settingsTable(
"Preferences",
[
["Language", "English"],
["Theme", "Light"],
["Notifications", "Enabled"],
],
),
];

return SingleChildScrollView(
padding: EdgeInsets.all(20),
child: isWide
? Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: sections[0],
),
SizedBox(width: 20),
Expanded(
child: sections[1],
),
],
)
    : Column(
children: [
sections[0],
SizedBox(height: 30),
sections[1],
],
),
);
},
),
),
);
}
}