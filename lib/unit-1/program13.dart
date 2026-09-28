void main() {
Set<String> myHobbies = {
"Music",
"Travel",
"Gaming",
"Photography"
};

Set<String> friendHobbies = {
"Gaming",
"Cricket",
"Music",
"Reading"
};

print("My Hobbies:");
print(myHobbies);

print("\nFriend's Hobbies:");
print(friendHobbies);

print("\nUnion:");
print(myHobbies.union(friendHobbies));

print("\nIntersection:");
print(myHobbies.intersection(friendHobbies));

print("\nDifference:");
print(myHobbies.difference(friendHobbies));
}