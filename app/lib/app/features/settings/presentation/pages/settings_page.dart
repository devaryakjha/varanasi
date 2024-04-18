import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:ui/ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Apperance'),
            tiles: [
              SettingsTile(
                title: const Text('Language'),
                leading: const Icon(Icons.language),
                trailing: const ThemeToggle(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
