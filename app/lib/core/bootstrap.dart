import 'dart:async';

import 'package:common/common.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi/core/utils/hydrated_bloc_init.dart';
import 'package:varanasi/flavors.dart';

class AppObserver extends BlocObserver {
  const AppObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    logInfo('onCreate -- bloc: $bloc');
  }
}

/// Bootstrap the application with Firebase and other services.
Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  FirebaseOptions options,
) async {
  /// Initialize the logger.
  initLogger('Varanasi ${F.name}');

  // Log Flutter errors to the console.
  FlutterError.onError = (details) {
    logError(
      details.exceptionAsString(),
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  // Ensure the WidgetsBinding is initialized before deferring the first frame.
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  // Enable Bloc observer.
  Bloc.observer = const AppObserver();

  // Initialize Firebase.
  await Firebase.initializeApp(options: options);

  // Initialise storage.
  await Storage.init();
  await initialiseHydratedBloc();

  // Run the application.
  binding.allowFirstFrame();

  // Run the application.
  runApp(await builder());
}
