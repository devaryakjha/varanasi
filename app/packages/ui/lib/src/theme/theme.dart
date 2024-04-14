import 'package:flutter/material.dart';

export 'theme_cubit.dart';
export 'theme_extension.dart';

ColorScheme createDarkColorScheme() {
  return const ColorScheme.dark();
}

ColorScheme createLightColorScheme() {
  return const ColorScheme.light();
}

ThemeData createDarkTheme() {
  return ThemeData(
    colorScheme: createDarkColorScheme(),
  );
}

ThemeData createLightTheme() {
  return ThemeData(
    colorScheme: createLightColorScheme(),
  );
}
