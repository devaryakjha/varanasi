import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/recent_media.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';

class RecentMediaService {
  static Box<RecentMedia> get _box =>
      Hive.box<RecentMedia>(AppStrings.recentMediaBoxName);

  /// Fetches the recent media from the cache
  static List<RecentMedia> getAllRecentMedia() => _box.values.toList()..sort();

  /// Adds the given [media] to the recent media cache
  static Future<void> addRecentMedia(RecentMedia media) {
    if (media.itemId.isEmpty) return Future.value();
    return _box.put(media.itemId, media);
  }

  /// Get the recent media from the cache for the given [itemId]
  static RecentMedia? getRecentMedia(String itemId) => _box.get(itemId);

  /// Stream of recent media
  static Stream<List<RecentMedia>> watchRecentMedia() => Rx.concat([
        Stream.value(getAllRecentMedia()),
        _box
            .watch()
            .map((_) => getAllRecentMedia())
            .distinctUnique(equals: listEquals),
      ]);

  static Future<int> clearRecentMedia() async {
    final result = await _box.clear();
    AppSnackbar.show("Cleared recent media");
    return result;
  }
}
