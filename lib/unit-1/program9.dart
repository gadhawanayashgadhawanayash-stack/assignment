double calculateArea(double radius) => 3.14 * radius * radius;

void main() {
double area1 = calculateArea(5);
double area2 = calculateArea(10);
double area3 = calculateArea(15);

print("Area for radius 5: $area1");
print("Area for radius 10: $area2");
print("Area for radius 15: $area3");
}
