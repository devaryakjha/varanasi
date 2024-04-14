import 'package:varanasi/app.dart';
import 'package:varanasi/core/bootstrap.dart';
import 'package:varanasi/core/firebase/firebase_options_staging.dart';
import 'package:varanasi/flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.staging;
  await bootstrap(
    () => const VaranasiApp(),
    DefaultFirebaseOptions.currentPlatform,
  );
}
