mixin Coding {
  void coding() {
    print("I can do Coding.");
  }
}

mixin Drawing {
  void drawing() {
    print("I can do Drawing.");
  }
}

mixin Gaming {
  void gaming() {
    print("I can do Gaming.");
  }
}

class MySkills with Coding, Drawing, Gaming {
  String name = "Yash";
}

void main() {
  MySkills skills = MySkills();

  print("My Name: ${skills.name}");
  skills.coding();
  skills.drawing();
  skills.gaming();
}
