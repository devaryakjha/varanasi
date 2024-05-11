import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/core/l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsPageTitle),
      ),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: Text(l10n.settingsApperanceTitle),
            tiles: [
              SettingsTile(
                title: Text(l10n.settingsThemeTitle),
                description: Text(l10n.settingsThemeDescription),
                onPressed: (context) => context.read<ThemeCubit>().toggle(),
                trailing: BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return ThemeToggleIcon(themeMode: themeMode);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
