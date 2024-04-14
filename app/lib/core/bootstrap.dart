import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {
  const AppObserver();

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log('onCreate -- bloc: $bloc');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange -- bloc: $bloc, change: $change');
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log('onClose -- bloc: $bloc');
  }
}

/// Bootstrap the application with Firebase and other services.
Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  FirebaseOptions options,
) async {
  // Log Flutter errors to the console.
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Ensure the WidgetsBinding is initialized before deferring the first frame.
  final binding = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();

  // Enable Bloc observer.
  Bloc.observer = const AppObserver();

  // Initialize Firebase.
  await Firebase.initializeApp(options: options);

  // Run the application.
  binding.allowFirstFrame();
  runApp(await builder());
}
