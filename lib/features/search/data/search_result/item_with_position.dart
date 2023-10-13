abstract class ItemWithPosition implements Comparable<ItemWithPosition> {
  int get position;

  @override
  int compareTo(ItemWithPosition other) {
    return position.compareTo(other.position);
  }
}
