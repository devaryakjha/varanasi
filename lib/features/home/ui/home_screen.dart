import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/helpers/home_state_selectors.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/media_carousel/media_carousel.dart';

import 'home_widgets/home_loader.dart';
import 'home_widgets/spacer.dart';
import 'home_widgets/trending/trending.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final (loading, modules, mediaPlaylist, _) =
        context.select(selectHomeStateData);

    return Scaffold(
      body: Visibility(
        visible: !loading,
        replacement: const HomePageLoader(),
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const FetchModules(refetch: true));
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (modules?.trending != null) ...[
                  HomeSpacer(height: padding.top),
                  TrendingSongsList(trending: modules!.trending!),
                ],
                ...mediaPlaylist.mapIndexed(
                  (index, e) {
                    return [
                      const HomeSpacer(),
                      MediaCarousel(playlist: e),
                      if (index == mediaPlaylist.length - 1)
                        HomeSpacer(height: padding.bottom),
                    ];
                  },
                ).expand((element) => element),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
