enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Varnasi Dev';
      case Flavor.staging:
        return 'Varnasi Staging';
      case Flavor.prod:
      case null:
        return 'Varnasi';
    }
  }
}
