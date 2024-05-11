import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi/app/features/discover/domain/repositories/discover_repository.dart';
import 'package:varanasi/app/features/discover/domain/use_cases/fetch_discover_data_use_case.dart';
import 'package:varanasi/app/features/discover/domain/use_cases/listen_discover_data_use_case.dart';
import 'package:varanasi/app/features/features.dart';
import 'package:varanasi/app/features/media_detail/data/data_source/media_detail_data_source_api.dart';
import 'package:varanasi/app/features/media_detail/data/repositories/media_detail_repository_impl.dart';
import 'package:varanasi/app/features/media_detail/domain/repositories/media_detail_repository.dart';
import 'package:varanasi/app/features/media_detail/domain/use_cases/fetch_artist_details_use_case.dart';
import 'package:varanasi/app/features/media_detail/domain/use_cases/listen_artist_details_use_case.dart';
import 'package:varanasi/app/features/media_detail/presentation/cubits/artist_detail/artist_detail_cubit.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';

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
    return BlocProvider(
      lazy: false,
      create: (context) {
        final repo = context.read<DiscoverRepository>();
        return DiscoverCubit(
          fetchDiscoverDataUseCase: FetchDiscoverDataUseCase(repo),
          listenDiscoverDataUseCase: ListenDiscoverDataUseCase(repo),
        )..fetchDiscoverData();
      },
      child: const DiscoverPage(),
    );
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
// ======= Account =======

@TypedGoRoute<SettingsRouteData>(
  path: '/settings',
  name: 'Settings',
)
class SettingsRouteData extends GoRouteData {
  const SettingsRouteData();
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

// ======= MediaDetail =======
@TypedGoRoute<MediaDetailRouteData>(
  path: '/media-detail/:type/:title/:subtitle/:image/:id',
  name: 'MediaDetail',
)
class MediaDetailRouteData extends GoRouteData {
  const MediaDetailRouteData({
    required this.type,
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  const MediaDetailRouteData.artist({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : type = MediaType.artist;

  const MediaDetailRouteData.album({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : type = MediaType.album;

  const MediaDetailRouteData.playlist({
    required this.id,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : type = MediaType.playlist;

  final MediaType type;
  final String id;
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RepositoryProvider<MediaDetailRepository>(
      key: ValueKey(type.name + id),
      create: (context) => MediaDetailRepositoryImpl(
        dataSource: MediaDetailDataRemoteSourceApi.forId(id),
      ),
      child: BlocProvider(
        lazy: false,
        create: (context) {
          final repo = context.read<MediaDetailRepository>();
          return ArtistDetailCubit(
            fetchArtistDetailsUseCase: FetchArtistDetailsUseCase(repo),
            listenArtistsDetailsDataUseCase:
                ListenArtistsDetailsDataUseCase(repo),
          )..fetchArtistDetails(id);
        },
        child: MediaDetailPage(
          image: image,
          id: id,
          title: title,
          subtitle: subtitle,
          type: type,
        ),
      ),
    );
  }
}
