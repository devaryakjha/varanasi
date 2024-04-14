import 'package:flutter/material.dart';
import 'package:varanasi/core/l10n/l10n.dart';
import 'package:varanasi/flavors.dart';

class VaranasiApp extends StatelessWidget {
  const VaranasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) {
        return context.l10n.appName(F.name);
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(context.l10n.appName(F.name)),
            ),
          );
        },
      ),
    );
  }
}
