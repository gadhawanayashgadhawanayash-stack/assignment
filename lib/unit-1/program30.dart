import 'dart:async';

Stream<int> rollNumberStream(int rollNumber) async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield rollNumber * i;
  }
}

Future<void> main() async {
  int rollNumber = 101;

  await for (int value in rollNumberStream(rollNumber)) {
    print("Emitted Value: $value");
  }
}
