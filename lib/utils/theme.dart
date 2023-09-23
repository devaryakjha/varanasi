library am_theme;

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = FlexThemeData.light(
  scheme: FlexScheme.pinkM3,
  appBarStyle: FlexAppBarStyle.scaffoldBackground,
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  textTheme: GoogleFonts.openSansTextTheme(),
  surfaceTint: Colors.transparent,
  platform: TargetPlatform.iOS,
);

final darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.pinkM3,
  appBarStyle: FlexAppBarStyle.scaffoldBackground,
  darkIsTrueBlack: true,
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  textTheme: GoogleFonts.openSansTextTheme(),
  surfaceTint: Colors.transparent,
  platform: TargetPlatform.iOS,
);
