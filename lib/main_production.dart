import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options_prod.dart';
import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  F.appFlavor = Flavor.production;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await runner.main();
}
