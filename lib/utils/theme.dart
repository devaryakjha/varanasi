library am_theme;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightTheme = darkTheme;

ThemeData darkTheme([FlexScheme? scheme]) => FlexThemeData.dark(
      scheme: scheme,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      darkIsTrueBlack: false,
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      textTheme: GoogleFonts.mPlusRounded1cTextTheme(),
      surfaceTint: Colors.transparent,
    );
