import 'package:go_router/go_router.dart';
import 'package:varanasi/core/routing/routes.dart';

final routerConfig = GoRouter(
  initialLocation: const DiscoverRouteData().location,
  routes: $appRoutes,
);
