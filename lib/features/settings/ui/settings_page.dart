import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/flavors.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';
import 'package:varanasi_mobile_app/utils/clear_cache.dart';
import 'package:varanasi_mobile_app/utils/dialogs/app_dialog.dart';
import 'package:varanasi_mobile_app/utils/extensions/flex_scheme.dart';
import 'package:varanasi_mobile_app/utils/services/recent_media_service.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig = context.select(
      (ConfigCubit cubit) => cubit.configLoadedState.config,
    );
    final packageInfo = context.select(
      (ConfigCubit cubit) => cubit.configLoadedState.packageInfo,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), centerTitle: true),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text("Account"),
            tiles: [
              SettingsTile(
                title: const Text("Sign out"),
                leading: const Icon(Icons.logout_outlined),
                onPressed: (context) {
                  context.read<SessionCubit>().signOut();
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text("General"),
            tiles: [
              SettingsTile.switchTile(
                initialValue: appConfig.isDataSaverEnabled,
                title: const Text("Data saver"),
                leading: const Icon(Icons.data_saver_on_outlined),
                onToggle: (value) {
                  AppConfig.getBox.put(
                    0,
                    appConfig.copyWith(
                      isDataSaverEnabled: value,
                      streamingQuality:
                          value ? DownloadQuality.low : DownloadQuality.extreme,
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: const Text('Download quality'),
                leading: const Icon(Icons.download_outlined),
                value: Text(
                  appConfig.downloadingQuality?.describeQuality ?? "",
                ),
                onPressed: (ctx) async {
                  AppConfig.effectiveDlQuality =
                      await AppDialog.showOptionsPicker(
                    ctx,
                    appConfig.downloadingQuality ?? DownloadQuality.high,
                    DownloadQuality.values,
                    (e) => e.describeQuality,
                    title: "Select Download Quality",
                  );
                },
              ),
              SettingsTile.navigation(
                title: const Text('Streaming quality'),
                leading: const Icon(Icons.music_note_outlined),
                value: Text(appConfig.streamingQuality?.describeQuality ?? ""),
                onPressed: (ctx) async {
                  AppConfig.effectivestreaQuality =
                      await AppDialog.showOptionsPicker(
                    ctx,
                    appConfig.streamingQuality ?? DownloadQuality.high,
                    DownloadQuality.values,
                    (e) => e.describeQuality,
                    title: "Select Streaming Quality",
                  );
                },
              ),
              SettingsTile.switchTile(
                initialValue: appConfig.isAdvancedModeEnabled,
                title: const Text("Advanced Settings"),
                leading: const Icon(Icons.settings_outlined),
                onToggle: (value) {
                  AppConfig.getBox.put(
                    0,
                    appConfig.copyWith(
                      isAdvancedModeEnabled: value,
                      streamingQuality: !value ? DownloadQuality.extreme : null,
                      colorScheme: !value ? 41 : null,
                    ),
                  );
                },
              ),
              SettingsTile.navigation(
                title: const Text("Clear Recently Played"),
                leading: const Icon(Icons.delete_forever_outlined),
                onPressed: (_) => RecentMediaService.clearRecentMedia(),
              ),
            ],
          ),
          _VisibileWhenSection(
            visible: appConfig.isAdvancedModeEnabled,
            title: const Text("Advanced"),
            tiles: [
              if (!appConfig.isDataSaverEnabled)
                SettingsTile.navigation(
                  leading: const Icon(Icons.format_paint_outlined),
                  title: const Text('Theme'),
                  value: Text(appConfig.scheme.describeScheme),
                  onPressed: (ctx) {
                    AppDialog.showOptionsPicker(
                      ctx,
                      appConfig.scheme,
                      FlexScheme.values,
                      (e) => e.describeScheme,
                      title: "Select Theme",
                    ).then((value) {
                      if (value != null) {
                        AppConfig.getBox.put(
                          0,
                          appConfig.copyWith(colorScheme: value.index),
                        );
                      }
                    });
                  },
                ),
              SettingsTile(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text("Clear cache"),
                onPressed: (ctx) {
                  if (isCacheEmpty()) {
                    FlushbarHelper.createInformation(
                      message: "Cache is already empty 👍🏻",
                    ).show(context);
                  } else {
                    AppDialog.showAlertDialog(
                      context: context,
                      title: "Clear cache",
                      message: "Are you sure you want to clear the cache?",
                      onConfirm: () {
                        clearCache().then((value) {
                          FlushbarHelper.createSuccess(
                            message: "Cache cleared 👍🏻",
                          ).show(context);
                        });
                      },
                    );
                  }
                },
              ),
            ],
          ),
          // show package info
          _VisibileWhenSection(
            visible: F.appFlavor.isDev,
            title: const Text("About (Dev Only)"),
            tiles: [
              SettingsTile(
                title: const Text("Version"),
                value: Text(packageInfo.version),
                leading: const Icon(Icons.info_outline),
              ),
              SettingsTile(
                title: const Text("Build number"),
                value: Text(packageInfo.buildNumber),
                leading: const Icon(Icons.info_outline),
              ),
              SettingsTile(
                title: const Text("App name"),
                value: Text(packageInfo.appName),
                leading: const Icon(Icons.info_outline),
              ),
              SettingsTile(
                title: const Text("App ID"),
                value: SelectableText(packageInfo.packageName),
                leading: const Icon(Icons.info_outline),
                onPressed: (context) {
                  Clipboard.setData(
                          ClipboardData(text: packageInfo.packageName))
                      .then((value) {
                    FlushbarHelper.createSuccess(
                      message: "App ID copied 👍🏻",
                    ).show(context);
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VisibileWhenSection extends SettingsSection {
  const _VisibileWhenSection({
    required super.tiles,
    super.title,
    this.visible = true,
  });

  final bool visible;

  @override
  Widget build(BuildContext context) {
    final child = visible ? super.build(context) : const SizedBox.shrink();
    return AnimatedSize(
      duration: kThemeAnimationDuration,
      child: child,
    );
  }
}
