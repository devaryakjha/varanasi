import 'dart:async';

import 'package:common/src/storage/storage_serializer.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'local_storage.dart';

sealed class Storage {
  const Storage();

  /// The local storage instance.
  ///
  /// This is a singleton instance of [LocalStorage].
  static const LocalStorage local = LocalStorage();

  /// Initialize the storage.
  ///
  /// call this before using any other methods.
  static Future<void> init() async {
    await local._init();
  }

  /// Save a value to the storage.
  Future<void> write<T>(
    String key,
    T value, {
    StorageSerializer<T>? serializer,
  });

  /// Read a value from the storage.
  ///
  /// If the value is not found, and [defaultValue] is provided,
  /// it will be returned.
  T? read<T>(String key, {T? defaultValue, StorageSerializer<T>? serializer});

  /// Delete a value from the storage.
  Future<void> delete(String key);

  /// Watch a value from the storage.
  ///
  /// This will return a stream that will emit the value for the provided key,
  /// whenever it changes.
  Stream<T?> watch<T>(
    String key, {
    T? initialData,
    StorageSerializer<T>? serializer,
  });
}
