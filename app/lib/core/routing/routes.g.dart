// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $dashboardRouteData,
      $mediaDetailRouteData,
      $settingsRouteData,
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
        StatefulShellBranchData.$branch(
          restorationScopeId: SearchBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/search',
              name: 'Search',
              factory: $SearchRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          restorationScopeId: LibraryBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/library',
              name: 'Library',
              factory: $LibraryRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          restorationScopeId: AccountBranchData.$restorationScopeId,
          routes: [
            GoRouteData.$route(
              path: '/account',
              name: 'Account',
              factory: $AccountRouteDataExtension._fromState,
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

extension $SearchRouteDataExtension on SearchRouteData {
  static SearchRouteData _fromState(GoRouterState state) =>
      const SearchRouteData();

  String get location => GoRouteData.$location(
        '/search',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $LibraryRouteDataExtension on LibraryRouteData {
  static LibraryRouteData _fromState(GoRouterState state) =>
      const LibraryRouteData();

  String get location => GoRouteData.$location(
        '/library',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AccountRouteDataExtension on AccountRouteData {
  static AccountRouteData _fromState(GoRouterState state) =>
      const AccountRouteData();

  String get location => GoRouteData.$location(
        '/account',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mediaDetailRouteData => GoRouteData.$route(
      path: '/media-detail/:type/:image/:id',
      name: 'MediaDetail',
      factory: $MediaDetailRouteDataExtension._fromState,
    );

extension $MediaDetailRouteDataExtension on MediaDetailRouteData {
  static MediaDetailRouteData _fromState(GoRouterState state) =>
      MediaDetailRouteData(
        type: _$MediaTypeEnumMap._$fromName(state.pathParameters['type']!),
        id: state.pathParameters['id']!,
        image: state.pathParameters['image']!,
      );

  String get location => GoRouteData.$location(
        '/media-detail/${Uri.encodeComponent(_$MediaTypeEnumMap[type]!)}/${Uri.encodeComponent(image)}/${Uri.encodeComponent(id)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

const _$MediaTypeEnumMap = {
  MediaType.artist: 'artist',
  MediaType.playlist: 'playlist',
  MediaType.album: 'album',
};

extension<T extends Enum> on Map<T, String> {
  T _$fromName(String value) =>
      entries.singleWhere((element) => element.value == value).key;
}

RouteBase get $settingsRouteData => GoRouteData.$route(
      path: '/settings',
      name: 'Settings',
      factory: $SettingsRouteDataExtension._fromState,
    );

extension $SettingsRouteDataExtension on SettingsRouteData {
  static SettingsRouteData _fromState(GoRouterState state) =>
      const SettingsRouteData();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
