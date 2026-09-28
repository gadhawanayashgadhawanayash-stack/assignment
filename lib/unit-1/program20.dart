class LowAttendanceException implements Exception {
String studentName;
double attendance;

LowAttendanceException(this.studentName, this.attendance);

@override
String toString() {

return "$studentName has low attendance: $attendance%";
}
}

void checkAttendance(String name, double attendance) {
if (attendance < 75) {
throw LowAttendanceException(name, attendance);
} else {
print("$name has sufficient attendance: $attendance%");
}
}

void main() {
String name = "Yash";
double attendance = 70;

try {
checkAttendance(name, attendance);
} catch (e) {
print("Error: $e");
}
}