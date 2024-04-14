part of 'storage.dart';

final class LocalStorage implements Storage {
  const LocalStorage();

  Box<dynamic> get _box => Hive.box('local_storage');

  Future<void> _init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>('local_storage');
  }

  void _ensureInitialized() {}

  @override
  Future<void> delete(String key) {
    _ensureInitialized();
    return _box.delete(key);
  }

  @override
  T? read<T>(String key, {T? defaultValue, StorageSerializer<T>? serializer}) {
    _ensureInitialized();
    final value = _box.get(key) as String?;
    if (value == null) return defaultValue;
    return serializer?.deserialize(value) ?? value as T;
  }

  @override
  Stream<T?> watch<T>(
    String key, {
    T? initialData,
    StorageSerializer<T>? serializer,
  }) async* {
    _ensureInitialized();
    yield read(key, defaultValue: initialData, serializer: serializer);
    yield* _box.watch(key: key).where((event) => !event.deleted).map(
      (event) {
        final value = event.value as String;
        return serializer?.deserialize(value) ?? event.value as T;
      },
    );
  }

  @override
  Future<void> write<T>(
    String key,
    T value, {
    StorageSerializer<T>? serializer,
  }) {
    _ensureInitialized();
    final serialized = serializer?.serialize(value) ?? value;
    return _box.put(key, serialized);
  }
}

class LocalStorageException implements Exception {
  LocalStorageException(this.message);
  final String message;

  @override
  String toString() => 'LocalStorageException: $message';
}
