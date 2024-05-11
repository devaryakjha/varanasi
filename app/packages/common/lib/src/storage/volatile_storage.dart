part of 'storage.dart';

final class VolatileStorage implements Storage {
  VolatileStorage();

  @override
  FutureOr<void> _init() {
    _storage = <String, String>{};
  }

  late final Map<String, String> _storage;

  @override
  Future<void> delete(String key) {
    _storage.remove(key);
    return Future.value();
  }

  @override
  T? read<T>(String key, {T? defaultValue, StorageSerializer<T>? serializer}) {
    final value = _storage[key];
    if (value == null) return defaultValue;
    if (serializer == null) return value as T;
    return serializer.deserialize(value) ?? value as T;
  }

  @override
  Stream<T?> watch<T>(
    String key, {
    T? initialData,
    StorageSerializer<T>? serializer,
  }) {
    return Stream.value(
      read(
        key,
        defaultValue: initialData,
        serializer: serializer,
      ),
    );
  }

  @override
  Future<void> write<T>(
    String key,
    T value, {
    StorageSerializer<T>? serializer,
  }) {
    final serialized = serializer?.serialize(value) ?? (value as String);
    _storage[key] = serialized;
    return Future.value();
  }
}
