import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';
import 'package:varanasi_mobile_app/utils/clear_cache.dart';
import 'package:varanasi_mobile_app/utils/dialogs/alert_dialog.dart';
import 'package:varanasi_mobile_app/utils/extensions/flex_scheme.dart';

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
                      downloadQuality:
                          value ? DownloadQuality.low : DownloadQuality.extreme,
                    ),
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
                      downloadQuality: !value ? DownloadQuality.extreme : null,
                      colorScheme: !value ? 41 : null,
                    ),
                  );
                },
              ),
            ],
          ),
          _VisibileWhenSection(
            visible: appConfig.isAdvancedModeEnabled,
            title: const Text("Advanced"),
            tiles: [
              if (!appConfig.isDataSaverEnabled)
                SettingsTile.navigation(
                  title: const Text('Streaming quality'),
                  leading: const Icon(Icons.music_note_outlined),
                  value: Text(appConfig.downloadQuality?.describeQuality ?? ""),
                  onPressed: (ctx) {
                    _showOptionsPicker(
                      ctx,
                      appConfig.downloadQuality,
                      DownloadQuality.values,
                      (e) => e?.describeQuality ?? "",
                    ).then((value) {
                      if (value != null) {
                        AppConfig.getBox
                            .put(0, appConfig.copyWith(downloadQuality: value));
                      }
                    });
                  },
                ),
              SettingsTile.navigation(
                leading: const Icon(Icons.format_paint_outlined),
                title: const Text('Theme'),
                value: Text(appConfig.scheme.describeScheme),
                onPressed: (ctx) {
                  _showOptionsPicker(ctx, appConfig.scheme, FlexScheme.values,
                      (e) => e.describeScheme).then((value) {
                    if (value != null) {
                      AppConfig.getBox
                          .put(0, appConfig.copyWith(colorScheme: value.index));
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
                    showAlertDialog(
                      context,
                      "Clear cache",
                      "Are you sure you want to clear the cache?",
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
          SettingsSection(
            title: const Text("About"),
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
                value: Text(packageInfo.packageName),
                leading: const Icon(Icons.info_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<T?> _showOptionsPicker<T>(
  BuildContext context,
  T initialValue,
  List<T> options,
  String Function(T) labelMapper,
) async {
  return await showCupertinoModalPopup<T>(
    context: context,
    builder: (context) {
      var selectedScheme = initialValue;
      final viewInsets = MediaQuery.viewInsetsOf(context);
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          height: 300,
          margin: EdgeInsets.only(bottom: viewInsets.bottom),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const Text("Close"),
                      onPressed: () => context.pop(),
                    ),
                    CupertinoButton(
                      child: const Text("Save"),
                      onPressed: () => context.pop(selectedScheme),
                    ),
                  ],
                ),
                Expanded(
                  child: CupertinoPicker(
                    magnification: 1.2,
                    useMagnifier: true,
                    itemExtent: 36,
                    onSelectedItemChanged: (int value) {
                      setState(() => selectedScheme = options[value]);
                    },
                    squeeze: 1.2,
                    scrollController: FixedExtentScrollController(
                      initialItem: options.indexOf(initialValue),
                    ),
                    children: options
                        .map((s) => Center(child: Text(labelMapper(s))))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      });
    },
  );
  // if (value != null) {
  //   await AppConfig.getBox.put(0, appConfig.copyWith(colorScheme: value));
  //   if (context.mounted) {
  //     FlushbarHelper.createSuccess(
  //       message: "Theme changed 👍🏻",
  //     ).show(context);
  //   }
  // }
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
