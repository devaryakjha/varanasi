library am_theme;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme([FlexScheme? scheme]) {
  return FlexThemeData.dark(
    scheme: scheme ?? FlexScheme.pinkM3,
    appBarStyle: FlexAppBarStyle.scaffoldBackground,
    useMaterial3ErrorColors: true,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    surfaceTint: Colors.transparent,
    textTheme: GoogleFonts.mPlusRounded1cTextTheme(),
    primaryTextTheme: GoogleFonts.mPlusRounded1cTextTheme(),
  );
}
