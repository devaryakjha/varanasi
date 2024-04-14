import 'package:flutter/material.dart';
import 'package:ui/src/theme/dark_theme.dart';
import 'package:ui/src/theme/light_theme.dart';
import 'package:ui/src/theme/text_theme.dart';

ThemeData _buildThemeData(
  ColorScheme colorScheme, {
  TextTheme? textTheme,
  bool isDarkTheme = false,
}) {
  return ThemeData(
    colorScheme: colorScheme,
    textTheme: textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

ThemeData buildLightTheme(BuildContext context) {
  return _buildThemeData(
    lightScheme,
    textTheme: buildTextTheme(context),
  );
}

ThemeData buildDarkTheme(BuildContext context) {
  return _buildThemeData(
    darkScheme,
    textTheme: buildTextTheme(context, isDarkTheme: true),
    isDarkTheme: true,
  );
}
