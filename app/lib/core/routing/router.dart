import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi/varanasi.dart';

final routerConfig = GoRouter(
  debugLogDiagnostics: kDebugMode,
  initialLocation: const DiscoverRouteData().location,
  routes: $appRoutes,
  navigatorKey: rootNavigatorKey,
);
