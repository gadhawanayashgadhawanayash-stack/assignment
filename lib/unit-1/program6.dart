double calculateSimpleInterest(
double principal, double rate, double time) {
return (principal * rate * time) / 100;
}

void main() {
double result1 = calculateSimpleInterest(10000, 5, 2);
double result2 = calculateSimpleInterest(5000, 6, 3);
double result3 = calculateSimpleInterest(20000, 4, 5);

print("Simple Interest 1: $result1");
print("Simple Interest 2: $result2");
print("Simple Interest 3: $result3");
}
