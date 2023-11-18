class RecentMediaService {
  // /// Fetches the recent media from the cache
  // static List<PlayableMedia> getAllRecentMedia() =>
  //     _box.values.toList()..sort();

  // /// Adds the given [media] to the recent media cache
  // static Future<void> addRecentMedia(RecentMedia media) {
  //   if (media.itemId.isEmpty) return Future.value();
  //   return _box.put(media.itemId, media);
  // }

  // /// Get the recent media from the cache for the given [itemId]
  // static RecentMedia? getRecentMedia(String itemId) => _box.get(itemId);

  // /// Stream of recent media
  // static Stream<List<RecentMedia>> watchRecentMedia() => Rx.concat([
  //       Stream.value(getAllRecentMedia()),
  //       _box
  //           .watch()
  //           .map((_) => getAllRecentMedia())
  //           .distinctUnique(equals: listEquals),
  //     ]);

  // static Future<int> clearRecentMedia() async {
  //   final result = await _box.clear();
  //   AppSnackbar.show("Cleared recent media");
  //   return result;
  // }
}
