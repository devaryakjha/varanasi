enum Flavor {
  development,
  production;

  bool get isDev => this == Flavor.development;
  bool get isProd => this == Flavor.production;
}

class F {
  static late Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Project Varanasi Dev';
      case Flavor.production:
        return 'Project Varanasi';
      default:
        return 'title';
    }
  }
}
