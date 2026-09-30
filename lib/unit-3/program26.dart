import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ComplexFormScreen(),
    );
  }
}

// Form Screen
class ComplexFormScreen extends StatefulWidget {
  @override
  State<ComplexFormScreen> createState() =>
      _ComplexFormScreenState();
}

class _ComplexFormScreenState extends State<ComplexFormScreen> {
  final formKey = GlobalKey<FormState>();

  String name = "";
  String? selectedCity;
  bool isStudent = false;

  final List<String> cities = [
    "Rajkot",
    "Ahmedabad",
    "Surat",
    "Vadodara",
  ];

  void submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SummaryScreen(
            name: name,
            city: selectedCity!,
            isStudent: isStudent,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Form"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              // TextFormField
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }

                  return null;
                },

                onSaved: (value) {
                  name = value!;
                },
              ),

              SizedBox(height: 20),

              // Dropdown
              DropdownButtonFormField<String>(
                value: selectedCity,

                decoration: InputDecoration(
                  labelText: "Select City",
                  border: OutlineInputBorder(),
                ),

                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },

                onSaved: (value) {
                  selectedCity = value;
                },

                validator: (value) {
                  if (value == null) {
                    return "Please select a city";
                  }

                  return null;
                },
              ),

              SizedBox(height: 10),

              // Checkbox
              CheckboxListTile(
                title: Text("I am a Student"),

                value: isStudent,

                onChanged: (value) {
                  setState(() {
                    isStudent = value!;
                  });
                },

                controlAffinity:
                ListTileControlAffinity.leading,
              ),

              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: submitForm,
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Summary Screen
class SummaryScreen extends StatelessWidget {
  final String name;
  final String city;
  final bool isStudent;

  SummaryScreen({
    required this.name,
    required this.city,
    required this.isStudent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Form Summary",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 30),

            Text(
              "Name: $name",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 15),

            Text(
              "City: $city",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 15),

            Text(
              "Student: ${isStudent ? "Yes" : "No"}",
              style: TextStyle(fontSize: 20),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back"),
            ),
          ],
        ),
      ),
    );
  }
}