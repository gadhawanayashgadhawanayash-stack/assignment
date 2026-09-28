class Book {
String title;

// Default named constructor
Book() : title = "Atomic Habits";

// Named constructor
Book.withTitle(this.title);

void displayBook() {
print("Book Title: $title");
}
}

void main() {
// Using default constructor
Book book1 = Book();
book1.displayBook();

// Using named constructor
Book book2 = Book.withTitle("The Alchemist");
book2.displayBook();
}