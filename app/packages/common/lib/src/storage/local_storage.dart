part of 'storage.dart';

final class LocalStorage implements Storage {
  LocalStorage() : _initCompleter = Completer.sync();

  final Completer<void> _initCompleter;

  Box<dynamic> get _box => Hive.box('local_storage');

  @override
  Future<void> _init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>('local_storage');
    _initCompleter.complete();
  }

  void _ensureInitialized() {
    if (!_initCompleter.isCompleted) {
      throw const LocalStorageException('LocalStorage is not initialized');
    }
  }

  @override
  Future<void> delete(String key) {
    _ensureInitialized();
    return _box.delete(key);
  }

  @override
  T? read<T>(String key, {T? defaultValue, StorageSerializer<T>? serializer}) {
    _ensureInitialized();
    if (serializer == null) {
      final value = _box.get(key, defaultValue: defaultValue);
      return value as T?;
    }
    final value = _box.get(key) as String?;
    if (value == null) return defaultValue;
    return serializer.deserialize(value) ?? value as T;
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
        if (serializer == null) return event.value as T;
        final value = event.value as String;
        return serializer.deserialize(value) ?? event.value as T;
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
  const LocalStorageException(this.message);
  final String message;

  @override
  String toString() => 'LocalStorageException: $message';
}
