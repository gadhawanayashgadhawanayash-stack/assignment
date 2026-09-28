void printMarks({
  required int mad,
  required int c,
  required int selfstudy,
  required int seo,
}) {
  print("Flutter: $mad");
  print("Dart: $c");
  print("Web Development: $selfstudy");
  print("Software Engineering: $seo");
}

void main() {
  printMarks(
    mad: 85,
    c: 80,
    selfstudy: 78,
    seo: 82,
  );
}
