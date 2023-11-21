import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

mixin CacheableService {
  bool initialised = false;

  Box get box;

  String get cacheBoxName;

  Future<Box?> initcache() async {
    try {
      if (initialised) return null;
      initialised = true;
      return await Hive.openBox(cacheBoxName);
    } catch (e) {
      initialised = false;
      rethrow;
    }
  }

  @mustCallSuper
  Future<void>? cache<E>(
    String key,
    E value, [
    Duration expiry = const Duration(days: 1),
  ]) {
    final data = <String, dynamic>{
      'value': value,
      'expiry': DateTime.now().add(expiry).millisecondsSinceEpoch,
    };
    return box.put(key, data);
  }

  E? maybeGetCached<E>(String key, [E? defaultValue]) {
    final data = box.get(key);
    if (data == null) return defaultValue;
    final expiry = data['expiry'] as int? ?? 0;
    if (DateTime.now().millisecondsSinceEpoch > expiry) {
      deleteCache(key);
      return defaultValue;
    }
    return data['value'] as E?;
  }

  @mustCallSuper
  Future<void>? deleteCache(String key) => box.delete(key);

  @mustCallSuper
  Future<int>? clearCache() => box.clear();
}
