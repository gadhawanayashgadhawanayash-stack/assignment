import 'dart:convert';

void main() {
  Map<String, dynamic> user = {
    "name": "Yash",
    "age": 21,
    "city": "Rajkot",
  };

  String jsonString = jsonEncode(user);

  print("Dart Map:");
  print(user);

  print("\nJSON String:");
  print(jsonString);
}