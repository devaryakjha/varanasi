import 'package:hive/hive.dart';

import 'constants/strings.dart';

/// Clears the cache of the app.
///
/// Returns a [Future] that completes when the cache is cleared.
Future<int> clearCache() {
  return Hive.box(AppStrings.commonCacheBoxName).clear();
}

/// Checks if the cache is empty.
///
/// Returns a [bool] that indicates if the cache is empty.
bool isCacheEmpty() {
  return Hive.box(AppStrings.commonCacheBoxName).isEmpty;
}
