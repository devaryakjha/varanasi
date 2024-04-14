import 'dart:convert';

abstract class StorageSerializer<T> {
  const StorageSerializer();

  // serialize
  String serialize(T value) {
    if (value is String) {
      return value;
    } else if (value is int) {
      return value.toString();
    } else if (value is double) {
      return value.toString();
    } else if (value is bool) {
      return value.toString();
    } else if (value is List) {
      return value.join(',');
    } else {
      throw Exception('Unsupported type: ${value.runtimeType}');
    }
  }

  // deserialize
  T deserialize(String value) {
    if (T == String) {
      return value as T;
    } else if (T == int) {
      return int.parse(value) as T;
    } else if (T == double) {
      return double.parse(value) as T;
    } else if (T == bool) {
      return (value == 'true') as T;
    } else if (T == List) {
      return value.split(',') as T;
    } else {
      throw Exception('Unsupported type: $T');
    }
  }
}

class JsonStorageSerializer implements StorageSerializer<Map<String, dynamic>> {
  const JsonStorageSerializer();
  @override
  String serialize(Map<String, dynamic> value) {
    return json.encode(value);
  }

  @override
  Map<String, dynamic> deserialize(String value) {
    return json.decode(value) as Map<String, dynamic>;
  }
}
