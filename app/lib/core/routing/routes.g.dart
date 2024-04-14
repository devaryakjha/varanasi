// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $dashboardRouteData,
    ];

RouteBase get $dashboardRouteData => StatefulShellRouteData.$route(
      restorationScopeId: DashboardRouteData.$restorationScopeId,
      navigatorContainerBuilder: DashboardRouteData.$navigatorContainerBuilder,
      factory: $DashboardRouteDataExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          restorationScopeId: DiscoverBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/discover',
              name: 'Discover',
              factory: $DiscoverRouteDataExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $DashboardRouteDataExtension on DashboardRouteData {
  static DashboardRouteData _fromState(GoRouterState state) =>
      const DashboardRouteData();
}

extension $DiscoverRouteDataExtension on DiscoverRouteData {
  static DiscoverRouteData _fromState(GoRouterState state) =>
      const DiscoverRouteData();

  String get location => GoRouteData.$location(
        '/discover',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
