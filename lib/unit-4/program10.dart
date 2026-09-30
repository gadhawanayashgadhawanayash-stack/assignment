import 'dart:convert';

void main() {
  String jsonString =
      '{"name":"Yash","age":21,"city":"Rajkot"}';

  Map<String, dynamic> user =
  jsonDecode(jsonString);

  print("Name: ${user["name"]}");
  print("Age: ${user["age"]}");
  print("City: ${user["city"]}");
}