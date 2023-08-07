import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_screen.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_screen.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/page_with_navbar.dart';

import 'keys.dart';

final routerConfig = GoRouter(
  initialLocation: AppRoutes.home.path,
  navigatorKey: rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
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
                    create: (context) => HomeBloc()..add(const FetchModules()),
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
                  lazy: false,
                  create: (context) => LibraryCubit()..fetchLibrary(media),
                  child: LibraryPage(source: media),
                );
              },
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return PageWithNavbar(child: navigationShell);
      },
    ),
  ],
);
