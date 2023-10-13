import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_screen.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_screen.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_search_page.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/ui/search_page.dart';
import 'package:varanasi_mobile_app/features/settings/ui/settings_page.dart';
import 'package:varanasi_mobile_app/features/user-library/ui/user_library_page.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/page_with_navbar.dart';
import 'package:varanasi_mobile_app/widgets/transitions/fade_transition_page.dart';

import 'keys.dart';

final routerConfig = GoRouter(
  initialLocation: AppRoutes.home.path,
  navigatorKey: rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: rootNavigatorKey,
      branches: [
        StatefulShellBranch(
          navigatorKey: homeShellNavigatorKey,
          routes: [
            GoRoute(
              name: AppRoutes.home.name,
              path: AppRoutes.home.path,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: BlocProvider(
                    lazy: false,
                    create: (context) => HomeBloc()..fetchModule(),
                    child: const HomePage(),
                  ),
                );
              },
            ),
            GoRoute(
              name: AppRoutes.library.name,
              path: AppRoutes.library.path,
              builder: (context, state) {
                final PlayableMedia media = state.extra! as PlayableMedia;
                return BlocProvider(
                  key: state.pageKey,
                  lazy: false,
                  create: (context) => LibraryCubit()..fetchLibrary(media),
                  child: LibraryPage(source: media),
                );
              },
              routes: [
                GoRoute(
                  name: AppRoutes.librarySearch.name,
                  path: AppRoutes.librarySearch.path,
                  pageBuilder: (context, state) {
                    final media = state.extra! as MediaPlaylist;
                    return FadeTransitionPage(
                      key: state.pageKey,
                      child: LibrarySearchPage(playlist: media),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: searchNavigatorKey,
          routes: [
            GoRoute(
              name: AppRoutes.search.name,
              path: AppRoutes.search.path,
              builder: (context, state) => SearchPage(key: state.pageKey),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: userLibraryNavigatorKey,
          routes: [
            GoRoute(
              name: AppRoutes.userlibrary.name,
              path: AppRoutes.userlibrary.path,
              builder: (context, state) => UserLibraryPage(key: state.pageKey),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return PageWithNavbar(child: navigationShell);
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: AppRoutes.settings.name,
      path: AppRoutes.settings.path,
      builder: (context, state) => BlocProvider(
        lazy: false,
        create: (context) => SearchCubit()..init(),
        child: SettingsPage(key: state.pageKey),
      ),
    ),
  ],
);
