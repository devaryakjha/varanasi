import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/helpers/home_state_selectors.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/spacer.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/trending/trending.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item_impl.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/generate_greeting.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/utils/services/recent_media_service.dart';
import 'package:varanasi_mobile_app/widgets/animated_overflow_text.dart';
import 'package:varanasi_mobile_app/widgets/error/error_page.dart';
import 'package:varanasi_mobile_app/widgets/tri_state_visibility.dart';

import 'home_widgets/home_loader.dart';
import 'home_widgets/media_carousel/media_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final (state, mediaPlaylist) = context.select(homePageDataSelector);
    final modules = switch (state) {
      (HomeLoadedState state) => state.modules,
      _ => null,
    };
    final greeting = generateGreeting();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Assets.icon.appIconMonotone.svg(width: 32, height: 32),
            const SizedBox(width: 8),
            AnimatedText(
              greeting,
              maxLines: 1,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings.path),
          ),
        ],
      ),
      body: TriStateVisibility(
        state: switch (state) {
          (HomeErrorState _) => TriState.error,
          (HomeLoadingState _) => TriState.loading,
          (_) => TriState.loaded,
        },
        loadingChild: const HomePageLoader(),
        errorChild: switch (state) {
          (HomeErrorState state) => ErrorPage(
              error: state.error,
              retryCallback: () {
                context.read<HomeCubit>().fetchModule(refetch: true);
              },
            ),
          _ => const SizedBox.shrink(),
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeCubit>().fetchModule(refetch: true);
          },
          child: ListView.builder(
            itemCount: mediaPlaylist.length,
            itemBuilder: (context, index) {
              final playlist = mediaPlaylist[index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (modules != null &&
                      modules.trending != null &&
                      index == 0) ...[
                    TrendingSongsList(trending: modules.trending!),
                    const RecentlyPlayed(),
                  ],
                  const HomeSpacer(),
                  MediaCarousel(playlist: playlist),
                  if (index == mediaPlaylist.length - 1)
                    HomeSpacer(height: padding.bottom),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  @override
  void initState() {
    RecentMediaService.setupListeners();
    super.initState();
  }

  @override
  void dispose() {
    RecentMediaService.disposeListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RecentMediaService.recentMediaStream,
      builder: (context, snapshot) {
        final mediaItems = snapshot.data ?? [];
        if (mediaItems.isEmpty) {
          return const SizedBox.shrink();
        }
        final parsed =
            mediaItems.map(PlayableMediaImpl.fromMediaPlaylist).toList();
        return Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: MediaCarousel(
            playlist: MediaPlaylist(
              id: 'recently-played',
              title: 'Recently Played',
              description: 'Your recently played songs',
              mediaItems: parsed,
              url: null,
            ),
            onItemTap: (index) {
              final item = mediaItems[index];
              if (item.isSong) {
                context
                    .read<MediaPlayerCubit>()
                    .playFromSong(PlayableMediaImpl.fromMediaPlaylist(item));
              } else {
                context.pushNamed(
                  AppRoutes.library.name,
                  extra: item,
                  pathParameters: {'id': item.id},
                );
              }
            },
          ),
        );
      },
    );
  }
}
