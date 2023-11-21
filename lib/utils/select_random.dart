import 'dart:math';

List<T> selectRandom<T>(List<T> items, int count) {
  var random = Random();
  items.shuffle(random);
  return items.take(count).toList();
}
