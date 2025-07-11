import 'dart:math';

extension ListExt<T> on List<T> {
  T randomItem() {
    final Random random = Random();
    final int index = random.nextInt(length);
    return this[index];
  }
}
