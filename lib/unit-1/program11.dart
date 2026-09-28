void main() {
List<String> movies = [
"Stranger Things",
"Avengers",
"Inception",
"Interstellar",
"3 Idiots"
];

print("Original List:");
print(movies);

movies.add("KGF");
print("\nAfter add:");
print(movies);

movies.remove("Avengers");
print("\nAfter remove:");
print(movies);

movies.sort();
print("\nAfter sort:");
print(movies);
}
