import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi/app/features/features.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<DashboardRouteData>(
  branches: [
    TypedStatefulShellBranch<DiscoverBranchData>(
      routes: [
        TypedGoRoute<DiscoverRouteData>(path: '/discover', name: 'Discover'),
      ],
    ),
  ],
)
class DashboardRouteData extends StatefulShellRouteData {
  const DashboardRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return navigationShell;
  }

  static const String $restorationScopeId = 'dashboardRestorationScopeId';

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return DashboardPage(
      navigationShell: navigationShell,
      children: children,
    );
  }
}

// ======= Discover =======
class DiscoverBranchData extends StatefulShellBranchData {
  const DiscoverBranchData();

  static const String $restorationScopeId = 'discoverRestorationScopeId';
}

class DiscoverRouteData extends GoRouteData {
  const DiscoverRouteData();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DiscoverPage();
  }
}
// ======= Discover =======
