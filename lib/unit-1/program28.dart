import 'dart:async';

Future<String> fetchCollegeName() async {
await Future.delayed(Duration(seconds: 2));
return "Atmiya University";
}

void main() {
fetchCollegeName().then((collegeName) {
print("College Name: $collegeName");
});

print("Message printed immediately.");
}