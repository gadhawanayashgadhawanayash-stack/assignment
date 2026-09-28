void main() {
int rollNumber = 11;

try {
int result = rollNumber ~/ 0;
print(result);
} catch (e) {
print("Error: Cannot divide roll number $rollNumber by zero.");
}
}