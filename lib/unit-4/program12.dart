import 'dart:convert';

class Student {
  String name;
  int age;
  String city;

  Student({
    required this.name,
    required this.age,
    required this.city,
  });

  // Convert Student object to Map
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "city": city,
    };
  }

  // Convert Map to Student object
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json["name"],
      age: json["age"],
      city: json["city"],
    );
  }
}

void main() {
  // Create Student object
  Student student1 = Student(
    name: "Yash",
    age: 21,
    city: "Rajkot",
  );

  // Object -> JSON
  Map<String, dynamic> jsonData = student1.toJson();

  print("Student Object converted to Map:");
  print(jsonData);

  // Map -> JSON String
  String jsonString = jsonEncode(jsonData);

  print("\nJSON String:");
  print(jsonString);

  // JSON String -> Map
  Map<String, dynamic> decodedData =
  jsonDecode(jsonString);

  // Map -> Student Object
  Student student2 =
  Student.fromJson(decodedData);

  print("\nStudent Object after conversion:");
  print("Name: ${student2.name}");
  print("Age: ${student2.age}");
  print("City: ${student2.city}");
}