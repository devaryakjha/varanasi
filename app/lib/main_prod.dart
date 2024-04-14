import 'package:varanasi/app.dart';
import 'package:varanasi/core/bootstrap.dart';
import 'package:varanasi/core/firebase/firebase_options.dart';
import 'package:varanasi/flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.prod;
  await bootstrap(
    () => const VaranasiApp(),
    DefaultFirebaseOptions.currentPlatform,
  );
}
