import 'package:varanasi/flavors.dart';
import 'package:varanasi/main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.staging;
  await runner.main();
}
