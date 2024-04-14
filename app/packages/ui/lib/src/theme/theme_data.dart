import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

ThemeData _buildThemeData(
  ColorScheme colorScheme, {
  TextTheme? textTheme,
  bool isDarkTheme = false,
}) {
  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
  );
}

ThemeData buildLightTheme(BuildContext context) {
  return _buildThemeData(lightScheme);
}

ThemeData buildDarkTheme(BuildContext context) {
  return _buildThemeData(
    darkScheme,
    isDarkTheme: true,
  );
}
