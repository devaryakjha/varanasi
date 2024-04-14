import 'package:flutter/material.dart';

export 'theme_cubit.dart';
export 'theme_extension.dart';

ColorScheme _createDarkColorScheme() {
  return const ColorScheme.dark(
    background: Colors.black,
  );
}

ColorScheme _createLightColorScheme() {
  return const ColorScheme.light();
}

ThemeData createDarkTheme() {
  return _createThemeData(_createDarkColorScheme()).copyWith(
    navigationBarTheme: _buildNavbarTheme(Colors.white),
  );
}

ThemeData createLightTheme() {
  return _createThemeData(_createLightColorScheme()).copyWith(
    navigationBarTheme: _buildNavbarTheme(Colors.black),
  );
}

NavigationBarThemeData _buildNavbarTheme(Color color) {
  return NavigationBarThemeData(
    backgroundColor: const Color(0xff474747),
    surfaceTintColor: const Color(0xff474747),
    indicatorColor: Colors.transparent,
    iconTheme: MaterialStatePropertyAll(
      IconThemeData(
        size: 24,
        color: color,
      ),
    ),
  );
}

ThemeData _createThemeData(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
