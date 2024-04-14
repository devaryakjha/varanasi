import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/core/l10n/l10n.dart';
import 'package:varanasi/flavors.dart';

class VaranasiApp extends StatelessWidget {
  const VaranasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      builder: (context, theme, darkTheme, themeMode) {
        return MaterialApp(
          theme: theme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) {
            return context.l10n.appName(F.name);
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    logInfo('Floating action button pressed');
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
