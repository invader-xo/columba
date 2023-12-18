import 'dart:math';

int pickARandomNumberInRange(int min, int max) {
  return min + Random().nextInt(max - min);
}

String getRandom5CharacterString() {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(5, (index) => chars[r.nextInt(chars.length)]).join();
}
