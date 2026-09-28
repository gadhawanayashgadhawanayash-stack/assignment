void main() {
Map<String, String> timetable = {
"Monday": "Flutter",
"Tuesday": "Dart",
"Wednesday": "Web Development",
"Thursday": "Database",
"Friday": "Software Engineering",
};

timetable.forEach((day, subject) {
print("$day: $subject");
});
}