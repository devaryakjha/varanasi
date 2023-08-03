import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/features/home/data/models/adapters.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  registerHomePageTypeAdapters();
  runApp(const Varanasi());
}
