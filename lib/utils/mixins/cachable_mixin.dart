import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

mixin CacheableService {
  bool initialised = false;

  Box get box;

  String get cacheBoxName;

  Future<Box?> initcache() async {
    try {
      if (initialised) return null;
      final box = await Hive.openBox(cacheBoxName);
      initialised = true;
      return box;
    } catch (e) {
      initialised = false;
      rethrow;
    }
  }

  @mustCallSuper
  Future<void>? cache<E>(String key, E value) {
    return box.put(key, value);
  }

  E? isCached<E>(String key, [E? defaultValue]) {
    return box.get(key, defaultValue: defaultValue);
  }

  @mustCallSuper
  Future<void>? deleteCache(String key) => box.delete(key);

  @mustCallSuper
  Future<int>? clearCache() => box.clear();
}
