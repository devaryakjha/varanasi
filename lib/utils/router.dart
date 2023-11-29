import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sheet/route.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_screen.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_screen.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_search_page.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/ui/search_page.dart';
import 'package:varanasi_mobile_app/features/session/cubit/session_cubit.dart';
import 'package:varanasi_mobile_app/features/session/ui/auth_page.dart';
import 'package:varanasi_mobile_app/features/session/ui/login_page.dart';
import 'package:varanasi_mobile_app/features/session/ui/signup_page.dart';
import 'package:varanasi_mobile_app/features/settings/ui/settings_page.dart';
import 'package:varanasi_mobile_app/features/user-library/ui/user_library_page.dart';
import 'package:varanasi_mobile_app/features/user-library/ui/widgets/add_to_playlist.dart';
import 'package:varanasi_mobile_app/features/user-library/ui/widgets/create_playlist.dart';
import 'package:varanasi_mobile_app/features/user-library/ui/widgets/search_and_add_to_playlist/search_and_add_to_playlist.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/page_with_navbar.dart';
import 'package:varanasi_mobile_app/widgets/transitions/fade_transition_page.dart';

import 'keys.dart';

class StreamListener<T> extends ChangeNotifier {
  /// Creates a [StreamListener].
  ///
  /// Every time the [Stream] receives an event this [ChangeNotifier] will
  /// notify its listeners.
  StreamListener(Stream<T> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<T> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

Page _pageWithBottomSheet(Widget child, [LocalKey? key]) =>
    MaterialExtendedPage(child: child, key: key);

final routerConfig = GoRouter(
  initialLocation: AppRoutes.authentication.path,
  navigatorKey: rootNavigatorKey,
  refreshListenable: StreamListener(FirebaseAuth.instance.userChanges()),
  redirect: (context, state) {
    final session = context.read<SessionCubit>().state;
    final forceLogin = state.uri.queryParameters['forceLogin'] == 'true';
    final allowedLoggedOutRoutes = [
      AppRoutes.authentication.name,
      AppRoutes.login.name,
      AppRoutes.signup.name,
    ].map(state.namedLocation);
    final isInsideAuth = allowedLoggedOutRoutes.contains(state.matchedLocation);
    return switch (session) {
      (UnAuthenticated _) when !isInsideAuth => AppRoutes.authentication.path,
      (Authenticated _) when isInsideAuth && !forceLogin => AppRoutes.home.path,
      _ => null,
    };
  },
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
                    create: (context) => HomeCubit()..init(),
                    child: const HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: searchNavigatorKey,
          routes: [
            GoRoute(
              name: AppRoutes.search.name,
              path: AppRoutes.search.path,
              pageBuilder: (_, state) => _pageWithBottomSheet(
                  BlocProvider(
                    lazy: true,
                    create: (context) => SearchCubit()..init(),
                    child: const SearchPage(),
                  ),
                  state.pageKey),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: userLibraryNavigatorKey,
          routes: [
            GoRoute(
              name: AppRoutes.userlibrary.name,
              path: AppRoutes.userlibrary.path,
              pageBuilder: (_, state) => _pageWithBottomSheet(
                const UserLibraryPage(),
                state.pageKey,
              ),
            ),
          ],
        ),
      ],
      pageBuilder: (_, __, shell) =>
          _pageWithBottomSheet(PageWithNavbar(child: shell)),
    ),
    GoRoute(
      name: AppRoutes.library.name,
      path: AppRoutes.library.path,
      pageBuilder: (context, state) {
        return _pageWithBottomSheet(
          LibraryPage(state.pathParameters['id']!, source: state.extra),
          state.pageKey,
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
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: AppRoutes.createLibrary.name,
      path: AppRoutes.createLibrary.path,
      pageBuilder: (_, state) => CupertinoSheetPage<void>(
        key: state.pageKey,
        child: const CreatePlaylistPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: AppRoutes.addToLibrary.name,
      path: AppRoutes.addToLibrary.path,
      pageBuilder: (_, state) => CupertinoSheetPage<void>(
        key: state.pageKey,
        child: AddToPlaylistPage(
          state.pathParameters['id']!,
          name: state.extra as String,
        ),
      ),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: AppRoutes.searchAndAddToLibrary.name,
      path: AppRoutes.searchAndAddToLibrary.path,
      pageBuilder: (_, state) {
        return CupertinoSheetPage<void>(
          key: state.pageKey,
          child: BlocProvider(
            create: (context) => SearchCubit()..init(),
            child: SearchAndAddToPlaylist(
              state.pathParameters['id']!,
              SearchFilter.all,
            ),
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: AppRoutes.settings.name,
      path: AppRoutes.settings.path,
      pageBuilder: (_, state) =>
          _pageWithBottomSheet(const SettingsPage(), state.pageKey),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: AppRoutes.authentication.name,
      path: AppRoutes.authentication.path,
      pageBuilder: (_, state) =>
          _pageWithBottomSheet(const AuthPage(), state.pageKey),
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          name: AppRoutes.login.name,
          path: AppRoutes.login.path,
          pageBuilder: (_, state) =>
              _pageWithBottomSheet(const LoginPage(), state.pageKey),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: AppRoutes.signup.path,
          name: AppRoutes.signup.name,
          pageBuilder: (_, state) =>
              _pageWithBottomSheet(const SignupPage(), state.pageKey),
        )
      ],
    ),
  ],
);
