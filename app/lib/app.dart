import 'package:flutter/material.dart';
import 'package:varanasi/core/l10n/l10n.dart';
import 'package:varanasi/flavors.dart';

class VaranasiApp extends StatelessWidget {
  const VaranasiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: F.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        appBar: AppBar(
          title: Text(F.title),
        ),
      ),
    );
  }
}
