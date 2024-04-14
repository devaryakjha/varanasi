import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  /// Returns the screen width.
  Size get size => MediaQuery.sizeOf(this);

  /// Returns the screen width.
  double get screenWidth => size.width;

  /// Returns the screen height.
  double get screenHeight => size.height;

  /// Returns the screen width divided by 100.
  double get screenWidthPercent => screenWidth / 100;

  /// Returns the screen height divided by 100.
  double get screenHeightPercent => screenHeight / 100;

  double screenHeightPercentOf(double percent) => screenHeightPercent * percent;
}

extension ThemeExtension on BuildContext {
  /// Returns the [ThemeData] of the current theme.
  ThemeData get theme => Theme.of(this);

  /// Returns the brightness of the current theme.
  Brightness get brightness => theme.brightness;

  /// Returns `true` if the current theme is dark.
  bool get isDark => brightness == Brightness.dark;

  /// Returns `true` if the current theme is light.
  bool get isLight => brightness == Brightness.light;
}

extension TextThemeExtension on BuildContext {
  /// Returns the [TextTheme] of the current theme.
  TextTheme get textTheme => theme.textTheme;

  /// Returns the [TextStyle] of the headline1 text style.
  TextStyle get displayLarge => textTheme.displayLarge!;

  /// Returns the [TextStyle] of the headline2 text style.
  TextStyle get displayMedium => textTheme.displayMedium!;

  /// Returns the [TextStyle] of the headline3 text style.
  TextStyle get displaySmall => textTheme.displaySmall!;

  /// Returns the [TextStyle] of the headline4 text style.
  TextStyle get headlineMedium => textTheme.headlineMedium!;

  /// Returns the [TextStyle] of the headline5 text style.
  TextStyle get headlineSmall => textTheme.headlineSmall!;

  /// Returns the [TextStyle] of the headline6 text style.
  TextStyle get titleLarge => textTheme.titleLarge!;

  /// Returns the [TextStyle] of the subtitle1 text style.
  TextStyle get titleMedium => textTheme.titleMedium!;

  /// Returns the [TextStyle] of the subtitle2 text style.
  TextStyle get titleSmall => textTheme.titleSmall!;

  /// Returns the [TextStyle] of the bodyText1 text style.
  TextStyle get bodyLarge => textTheme.bodyLarge!;

  /// Returns the [TextStyle] of the bodyText2 text style.
  TextStyle get bodyMedium => textTheme.bodyMedium!;

  /// Returns the [TextStyle] of the caption text style.
  TextStyle get bodySmall => textTheme.bodySmall!;

  /// Returns the [TextStyle] of the button text style.
  TextStyle get labelLarge => textTheme.labelLarge!;

  /// Returns the [TextStyle] of the overline text style.
  TextStyle get labelSmall => textTheme.labelSmall!;
}

extension DefaultTextStyleExtension on BuildContext {
  /// Returns the [DefaultTextStyle] of the current theme.
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  /// Returns the [TextStyle] of the default text style.
  TextStyle get _style => defaultTextStyle.style;

  /// Returns the [Color] of the default text style.
  Color? get defaultForegroundColor => _style.color;
}

extension ButtonThemeExtension on BuildContext {
  /// Returns the [ButtonThemeData] of the current theme.
  ButtonThemeData get buttonTheme => ButtonTheme.of(this);

  /// Returns the [ButtonStyle] of the elevated button.
  ButtonStyle get elevatedButtonStyle => theme.elevatedButtonTheme.style!;

  /// Returns the [ButtonStyle] of the filled button.
  ButtonStyle get filledButtonStyle => theme.filledButtonTheme.style!;

  /// Returns the [ButtonStyle] of the outlined button.
  ButtonStyle get outlinedButtonStyle => theme.outlinedButtonTheme.style!;

  /// Returns the [ButtonStyle] of the text button.
  ButtonStyle get textButtonStyle => theme.textButtonTheme.style!;

  Color? get foregroundColor =>
      filledButtonStyle.foregroundColor?.resolve({MaterialState.focused});
}
