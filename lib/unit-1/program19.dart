void main() {
String name = "Yash";

List<String> foods = [
"shak",
"rotali",
"dal-bhat"
];

try {
int number = int.parse(name);
print("Converted number: $number");

print("Favourite food: ${foods[5]}");
} on FormatException {
print("Error: '$name' cannot be converted to an integer.");
} on RangeError {
print("Error: The food list index is out of range.");
}
}