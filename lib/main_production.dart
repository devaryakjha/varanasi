import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'firebase_options_prod.dart';
import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.production;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await runner.main();
}
