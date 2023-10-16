import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/features/home/data/models/adapters.dart';

import 'app.dart';
import 'models/adapters.dart';
import 'models/app_config.dart';
import 'utils/constants/strings.dart';

Future<void> main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  registerCommonTypeAdapters();
  registerHomePageTypeAdapters();
  await AppConfig.openBox();
  await Hive.openBox(AppStrings.commonCacheBoxName);
  FlutterNativeSplash.remove();
  runApp(const Varanasi());
}
