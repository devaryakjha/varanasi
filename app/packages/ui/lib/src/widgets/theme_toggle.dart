import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

typedef ThemeModeWidgetBuilder = Widget Function(
  BuildContext context,
  ThemeMode themeMode,
);

/// A widget that toggles the theme.
///
/// This widget is a convenience wrapper around a [IconButton] that toggles the
/// theme when pressed. It is intended to be used in the [AppBar] of the app.
class ThemeToggle extends StatelessWidget {
  const ThemeToggle({
    super.key,
    this.builder,
  });

  final ThemeModeWidgetBuilder? builder;

  Widget _defaultBuilder(BuildContext context, ThemeMode themeMode) {
    return Icon(
      themeMode == ThemeMode.system
          ? Icons.brightness_auto
          : themeMode == ThemeMode.light
              ? Icons.brightness_4
              : Icons.brightness_7,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    return IconButton(
      onPressed: context.read<ThemeCubit>().toggle,
      icon: builder != null
          ? builder!(context, themeMode)
          : _defaultBuilder(context, themeMode),
    );
  }
}
