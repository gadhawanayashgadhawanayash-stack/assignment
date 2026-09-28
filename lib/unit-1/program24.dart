abstract class Shape {
double area();
double perimeter();
}

class Triangle extends Shape {
double base;
double height;
double side1;
double side2;
double side3;

Triangle(
this.base,
this.height,
this.side1,
this.side2,
this.side3,
);

@override
double area() {
return 0.5 * base * height;
}

@override
double perimeter() {
return side1 + side2 + side3;
}
}

class Square extends Shape {
double side;

Square(this.side);

@override
double area() {
return side * side;
}

@override
double perimeter() {
return 4 * side;
}
}

void main() {
Triangle triangle = Triangle(10, 8, 6, 7, 9);

print("Triangle Area: ${triangle.area()}");
print("Triangle Perimeter: ${triangle.perimeter()}");

Square square = Square(5);

print("Square Area: ${square.area()}");
print("Square Perimeter: ${square.perimeter()}");
}