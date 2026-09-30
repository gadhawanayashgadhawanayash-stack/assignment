import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class SkillSelector extends StatefulWidget {
  @override
  State<SkillSelector> createState() => _SkillSelectorState();
}

class _SkillSelectorState extends State<SkillSelector> {
  List<String> skills = [
    "Flutter",
    "Dart",
    "Java",
    "Python",
    "PHP",
    "HTML",
    "CSS",
    "MySQL",
  ];

  List<String> selectedSkills = [];

  void toggleSkill(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Skill Selector")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Your Skills",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) {
                return ChoiceChip(
                  label: Text(skill),
                  selected: selectedSkills.contains(skill),
                  onSelected: (selected) {
                    toggleSkill(skill);
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 30),

            Text(
              "Selected Skills:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              selectedSkills.isEmpty
                  ? "No skill selected"
                  : selectedSkills.join(", "),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SkillSelector());
  }
}
