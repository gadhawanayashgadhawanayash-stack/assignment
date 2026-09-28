class Drawable {
void draw() {
print("Drawing photo...");
}
}

class Resizable {
void resize() {
print("Resizing photo...");
}
}

class Photo implements Drawable, Resizable {
String fileName;

Photo(this.fileName);

@override
void draw() {
print("Drawing: $fileName");
}

@override
void resize() {
print("Resizing: $fileName");
}

void displayDetails() {
print("Photo File Name: $fileName");
}
}

void main() {
Photo photo = Photo("my_photo.jpg");

photo.displayDetails();
photo.draw();
photo.resize();
}