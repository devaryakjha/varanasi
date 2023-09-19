dynamic parseValue(value) {
  if (value is Map) {
    return convertNestedMap(value);
  }
  if (value is List) {
    return value.map(parseValue).toList();
  }
  return value;
}

Map<K, V> convertNestedMap<K extends String, V extends dynamic>(Map nestedMap) {
  Map<K, V> result = {};
  nestedMap.forEach((key, value) {
    result[key] = parseValue(value);
  });
  return result;
}
