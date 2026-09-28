void main() {
String? careerGoal;

print("Initial career goal: $careerGoal");

String displayGoal = careerGoal ?? "Not decided yet";
print("Default career goal: $displayGoal");

careerGoal ??= "app Developer";
print("Actual career goal: $careerGoal");
}