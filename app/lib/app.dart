import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/flavors.dart';
import 'package:varanasi/varanasi.dart';

class VaranasiApp extends StatelessWidget {
  const VaranasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppInjector(
      builder: (context) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              routerConfig: routerConfig,
              themeMode: themeMode,
              theme: createLightTheme(),
              darkTheme: createDarkTheme(),
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) {
                return context.l10n.appName(F.name);
              },
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
