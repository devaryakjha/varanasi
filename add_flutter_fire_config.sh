flutterfire configure -i dev.aryak.varanasi.dev -a dev.aryak.varanasi.dev --ios-out ios/config/development/GoogleService-Info.plist --android-out android/app/src/development/google-services.json -o lib/firebase_options_dev.dart
flutterfire configure -i dev.aryak.varanasi -a dev.aryak.varanasi --ios-out ios/config/production/GoogleService-Info.plist --android-out android/app/src/production/google-services.json -o lib/firebase_options_prod.dart