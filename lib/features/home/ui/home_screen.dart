import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/bloc/home_bloc.dart';
import 'package:varanasi_mobile_app/features/home/data/helpers/home_state_selectors.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/spacer.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/trending/trending.dart';
import 'package:varanasi_mobile_app/utils/generate_greeting.dart';
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
        title: AnimatedText(greeting, maxLines: 1),
        actions: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: TriStateVisibility(
        state: switch (state.runtimeType) {
          HomeErrorState => TriState.error,
          HomeLoadingState => TriState.loading,
          _ => TriState.loaded,
        },
        loadingChild: const HomePageLoader(),
        errorChild: switch (state) {
          (HomeErrorState state) => ErrorPage(
              error: state.error,
              retryCallback: () {
                context.read<HomeBloc>().fetchModule(refetch: true);
              },
            ),
          _ => const SizedBox.shrink(),
        },
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().fetchModule(refetch: true);
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
    // return Scaffold(
    //   appBar: state is HomeLoadedState
    //       ? AppBar(
    //           centerTitle: false,
    //           title: AnimatedText(greeting, maxLines: 1),
    //           actions: [
    //             IconButton(
    //               iconSize: 30,
    //               icon: const Icon(Icons.settings_outlined),
    //               onPressed: () {},
    //             ),
    //           ],
    //         )
    //       : null,
    //   body: TriStateVisibility(
    //     state: switch (state.runtimeType) {
    //       HomeErrorState => TriState.error,
    //       HomeLoadingState => TriState.loading,
    //       _ => TriState.loaded,
    //     },
    //     loadingChild: const HomePageLoader(),
    //     errorChild: switch (state) {
    //       (HomeErrorState state) => ErrorPage(
    //           error: state.error,
    //           retryCallback: () {
    //             context.read<HomeBloc>().fetchModule(refetch: true);
    //           },
    //         ),
    //       _ => const SizedBox.shrink(),
    //     },
    //     child: RefreshIndicator(
    //       onRefresh: () async {
    //         context.read<HomeBloc>().fetchModule(refetch: true);
    //       },
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             if (modules != null && modules.trending != null) ...[
    //               TrendingSongsList(trending: modules.trending!),
    //             ],
    //             ...mediaPlaylist.mapIndexed(
    //               (index, e) {
    //                 return [
    //                   const HomeSpacer(),
    //                   MediaCarousel(playlist: e),
    //                   if (index == mediaPlaylist.length - 1)
    //                     HomeSpacer(height: padding.bottom),
    //                 ];
    //               },
    //             ).expand((element) => element),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
