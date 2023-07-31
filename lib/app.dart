import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';
import 'package:varanasi_mobile_app/utils/router.dart';

class Varanasi extends StatelessWidget {
  const Varanasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      routerConfig: routerConfig,
      debugShowCheckedModeBanner: false,
    );
  }
}
