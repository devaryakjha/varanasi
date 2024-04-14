import 'package:common/common.dart';
import 'package:flutter/material.dart';

class ThemeModeSerializer implements StorageSerializer<ThemeMode> {
  const ThemeModeSerializer();

  @override
  ThemeMode deserialize(String value) {
    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  String serialize(ThemeMode value) {
    return value.name;
  }
}
