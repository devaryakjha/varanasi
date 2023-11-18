import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:varanasi_mobile_app/firebase_options_dev.dart';

import 'flavors.dart';
import 'main.dart' as runner;
import 'utils/bloc_observer.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  F.appFlavor = Flavor.development;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9000);
  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  Bloc.observer = AppBlocObserver();
  await runner.main();
}
