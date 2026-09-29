import 'dart:async';

Future<String> fetchName() async {
await Future.delayed(Duration(seconds: 1));
return "Yash";
}

Future<int> fetchRollNumber() async {
await Future.delayed(Duration(seconds: 1));
return 11;
}

Future<String> fetchResult() async {
await Future.delayed(Duration(seconds: 1));
return "Pass";
}

Future<void> main() async {
String name = await fetchName();
print("Name: $name");

int rollNumber = await fetchRollNumber();
print("Roll Number: $rollNumber");

String result = await fetchResult();
print("Final Result: $result");
}