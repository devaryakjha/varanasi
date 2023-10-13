import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/utils/clear_cache.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/extensions/flex_scheme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appConfig =
        context.select((ConfigCubit cubit) => cubit.configLoadedState.config);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBackground.resolveFrom(context),
        middle: Text("Settings", style: context.textTheme.titleLarge),
        previousPageTitle: "Home",
      ),
      child: SettingsList(
        sections: [
          SettingsSection(
            title: const Text("General"),
            tiles: [
              SettingsTile.switchTile(
                initialValue: appConfig.isDataSaverEnabled,
                title: const Text("Data saver"),
                leading: const Icon(Icons.data_saver_on_outlined),
                onToggle: (value) {
                  AppConfig.getBox
                      .put(0, appConfig.copyWith(isDataSaverEnabled: value));
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text("Advanced"),
            tiles: [
              SettingsTile(
                leading: const Icon(Icons.delete_forever_outlined),
                title: const Text("Clear cache"),
                onPressed: (ctx) => isCacheEmpty()
                    ? {
                        FlushbarHelper.createInformation(
                          message: "Cache is already empty 👍🏻",
                        ).show(context),
                      }
                    : clearCache().then((value) {
                        FlushbarHelper.createSuccess(
                          message: "Cache cleared 👍🏻",
                        ).show(context);
                      }),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.format_paint_outlined),
                title: const Text('Theme'),
                value: Text(appConfig.scheme.describeScheme),
                onPressed: (ctx) => _handleOnPressed(ctx, appConfig),
              ),
            ],
          )
        ],
      ),
    );
  }
}

void _handleOnPressed(
  BuildContext context,
  AppConfig appConfig,
) async {
  final int initialValue = appConfig.colorScheme;
  final value = await showCupertinoModalPopup<int?>(
    context: context,
    builder: (context) {
      var selectedScheme = initialValue;
      final viewInsets = MediaQuery.viewInsetsOf(context);
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          height: 300,
          margin: EdgeInsets.only(bottom: viewInsets.bottom),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
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
                    looping: true,
                    magnification: 1.2,
                    useMagnifier: true,
                    itemExtent: 36,
                    onSelectedItemChanged: (int value) {
                      setState(() {
                        selectedScheme = value;
                      });
                    },
                    squeeze: 1.2,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedScheme,
                    ),
                    children: FlexScheme.values
                        .map((s) => Center(child: Text(s.describeScheme)))
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
  if (value != null) {
    await AppConfig.getBox.put(0, appConfig.copyWith(colorScheme: value));
    if (context.mounted) {
      FlushbarHelper.createSuccess(
        message: "Theme changed 👍🏻",
      ).show(context);
    }
  }
}
