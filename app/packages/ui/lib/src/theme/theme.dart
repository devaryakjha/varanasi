import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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
  return _createThemeData(
    _createDarkColorScheme(),
    _buildTextTheme(isDarkTheme: true),
    _buildAppBarTheme(isDarkTheme: true),
    _buildFloatingActionButtonThemeData(),
  ).copyWith(
    navigationBarTheme: _buildNavbarTheme(Colors.white),
  );
}

ThemeData createLightTheme() {
  return _createThemeData(
    _createLightColorScheme(),
    _buildTextTheme(),
    _buildAppBarTheme(),
    _buildFloatingActionButtonThemeData(),
  ).copyWith(
    navigationBarTheme: _buildNavbarTheme(Colors.black),
  );
}

NavigationBarThemeData _buildNavbarTheme(Color color) {
  return NavigationBarThemeData(
    backgroundColor: Colors.grey,
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

TextTheme _buildTextTheme({bool isDarkTheme = false}) {
  final color = isDarkTheme ? Colors.white : Colors.black;
  final base = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 1.4,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.67,
    ),
    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.75,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.72,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.72,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 1.67,
    ),
    labelLarge: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      height: 1.6,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      height: 1.6,
    ),
  ).apply(
    displayColor: color,
    bodyColor: color,
    decorationColor: color,
  );
  return GoogleFonts.poppinsTextTheme(base);
}

AppBarTheme _buildAppBarTheme({bool isDarkTheme = false}) {
  return AppBarTheme(
    color: isDarkTheme ? Colors.black : Colors.white,
    surfaceTintColor: isDarkTheme ? Colors.black : Colors.white,
    foregroundColor: isDarkTheme ? Colors.white : Colors.black,
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 10,
    systemOverlayStyle:
        isDarkTheme ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
  );
}

FloatingActionButtonThemeData _buildFloatingActionButtonThemeData() {
  return const FloatingActionButtonThemeData(shape: CircleBorder());
}

ThemeData _createThemeData(
  ColorScheme colorScheme,
  TextTheme textTheme,
  AppBarTheme appBarTheme,
  FloatingActionButtonThemeData floatingActionButtonTheme,
) {
  return ThemeData(
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    floatingActionButtonTheme: floatingActionButtonTheme,
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textTheme: textTheme,
  );
}
