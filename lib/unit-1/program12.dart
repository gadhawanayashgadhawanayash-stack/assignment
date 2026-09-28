void main() {
List<int> marks = [45, 60, 35, 75, 48, 80];

print("Original Marks:");
print(marks);

List<int> graceMarks = marks.map((mark) => mark + 5).toList();

print("\nAfter adding 5 grace marks:");
print(graceMarks);

List<int> filteredMarks =
graceMarks.where((mark) => mark >= 50).toList();

print("\nMarks 50 and above:");
print(filteredMarks);
}