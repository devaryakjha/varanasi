import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/media_carousel/media_carousel.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';

import 'home_widgets/home_loader.dart';
import 'home_widgets/spacer.dart';
import 'home_widgets/trending/trending.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final (loading, modules, mediaPlaylist) = context.select(
      (HomeBloc value) {
        final modules = value.state.modules;
        final mediaPlaylist = [
          if (modules?.charts != null)
            MediaPlaylist(
              title: 'Popular Today',
              mediaItems: modules!.charts!,
            ),
          if (modules?.albums != null)
            MediaPlaylist(
              title: 'Albums',
              mediaItems: modules!.albums!,
            ),
          if (modules?.playlists != null)
            MediaPlaylist(
              title: 'Playlists',
              mediaItems: modules!.playlists!,
            ),
        ];
        return (value.state.isLoading, modules, mediaPlaylist);
      },
    );

    return Scaffold(
      body: Visibility(
        visible: !loading,
        replacement: const HomePageLoader(),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              return context
                  .read<HomeBloc>()
                  .add(const FetchModules(refetch: true));
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (modules?.trending != null) ...[
                    TrendingSongsList(trending: modules!.trending!),
                  ],
                  ...mediaPlaylist.map(
                    (e) {
                      return [const HomeSpacer(), MediaCarousel(playlist: e)];
                    },
                  ).expand((element) => element),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
