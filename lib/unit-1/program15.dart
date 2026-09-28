void main() {
Map<String, String> friends = {
"Brijesh": "Blue",
"Pratik": "Black",
"Rahul": "Red",
"Dhruv": "Green",
"Harsh": "Yellow",
};

friends.putIfAbsent("Yash", () => "White");

print("Friends and their favourite colours:");

friends.forEach((name, colour) {
print("$name: $colour");
});
}