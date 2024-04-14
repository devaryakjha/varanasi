// create a theme provider which accepts a widget builder function
//and passes light theme, dark theme and theme mode to it

import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/src/theme/theme_data.dart';
import 'package:ui/src/theme/theme_mode_serializer.dart';

typedef ThemeWidgetBuilder = Widget Function(
  BuildContext context,
  ThemeData lightTheme,
  ThemeData darkTheme,
  ThemeMode themeMode,
);

class ThemeProvider extends StatelessWidget {
  const ThemeProvider({required this.builder, super.key});
  final ThemeWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyT):
            const ToggleThemeIntent(),
      },
      child: StorageListener<ThemeMode>(
        listenableKey: 'theme_mode',
        initialData: ThemeMode.system,
        serializer: const ThemeModeSerializer(),
        builder: (context, mode, toggleMode) {
          final currentThemeMode = mode ?? ThemeMode.system;
          return Actions(
            actions: <Type, Action<Intent>>{
              ToggleThemeIntent: ToggleThemeAction(
                currentThemeMode,
                toggleMode,
              ),
            },
            child: builder(
              context,
              buildLightTheme(context),
              buildDarkTheme(context),
              currentThemeMode,
            ),
          );
        },
      ),
    );
  }
}

class ToggleThemeIntent extends Intent {
  const ToggleThemeIntent();
}

class ToggleThemeAction extends Action<ToggleThemeIntent> {
  ToggleThemeAction(this.mode, this.toggleMode);
  final ThemeMode mode;
  Future<void> Function(ThemeMode) toggleMode;

  @override
  Future<void> invoke(covariant ToggleThemeIntent intent) async {
    final nextMode = mode == ThemeMode.system
        ? ThemeMode.light
        : mode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;

    await toggleMode(nextMode);
  }
}
