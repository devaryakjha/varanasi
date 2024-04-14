import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/ui.dart' show TextThemeExtension;

TextTheme buildTextTheme(BuildContext context, {bool isDarkTheme = false}) {
  final color = isDarkTheme ? Colors.black : Colors.white;
  final base = context.textTheme
      .copyWith(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
        displayMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.4,
        ),
        titleMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          height: 1.67,
        ),
        titleSmall: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.75,
        ),
        bodyLarge: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.72,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.72,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.67,
        ),
        labelLarge: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        labelMedium: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          height: 1.6,
        ),
      )
      .apply(
        displayColor: color,
        bodyColor: color,
        decorationColor: color,
      );
  return GoogleFonts.mulishTextTheme(base);
}
