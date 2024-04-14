import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi/app/features/account/presentation/pages/account_page.dart';
import 'package:varanasi/app/features/features.dart';
import 'package:varanasi/app/features/library/presentation/pages/library_page.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<DashboardRouteData>(
  branches: [
    TypedStatefulShellBranch<DiscoverBranchData>(
      routes: [
        TypedGoRoute<DiscoverRouteData>(path: '/discover', name: 'Discover'),
      ],
    ),
    TypedStatefulShellBranch<SearchBranchData>(
      routes: [
        TypedGoRoute<SearchRouteData>(path: '/search', name: 'Search'),
      ],
    ),
    TypedStatefulShellBranch<LibraryBranchData>(
      routes: [
        TypedGoRoute<LibraryRouteData>(path: '/library', name: 'Library'),
      ],
    ),
    TypedStatefulShellBranch<AccountBranchData>(
      routes: [
        TypedGoRoute<AccountRouteData>(path: '/account', name: 'Account'),
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

// ======= Search =======
class SearchBranchData extends StatefulShellBranchData {
  const SearchBranchData();

  static const String $restorationScopeId = 'searchRestorationScopeId';
}

class SearchRouteData extends GoRouteData {
  const SearchRouteData();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SearchPage();
  }
}
// ======= Search =======

// ======= Library =======
class LibraryBranchData extends StatefulShellBranchData {
  const LibraryBranchData();

  static const String $restorationScopeId = 'libraryRestorationScopeId';
}

class LibraryRouteData extends GoRouteData {
  const LibraryRouteData();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LibraryPage();
  }
}
// ======= Library =======

// ======= Account =======
class AccountBranchData extends StatefulShellBranchData {
  const AccountBranchData();

  static const String $restorationScopeId = 'accountRestorationScopeId';
}

class AccountRouteData extends GoRouteData {
  const AccountRouteData();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AccountPage();
  }
}
// ======= Library =======
