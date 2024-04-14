import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  FirebaseOptions options,
) async {
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  await Firebase.initializeApp(options: options);
  binding.allowFirstFrame();
  runApp(await builder());
}
