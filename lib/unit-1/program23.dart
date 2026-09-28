class Person {
String name;

Person(this.name);

void introduce() {
print("I am a person. My name is $name.");
}
}

class Teacher extends Person {
String subject;

Teacher(String name, this.subject) : super(name);

@override
void introduce() {
print("My name is $name.");
print("My favourite teacher's subject is $subject.");
}
}

void main() {
Teacher teacher = Teacher("Yash", "Flutter");

teacher.introduce();
}