import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/find_in_playlist.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/sort_by_toggle.dart';
import 'package:varanasi_mobile_app/utils/constants/dimensions.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

class LibraryContent extends StatefulWidget {
  const LibraryContent({super.key});

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(context.topPadding);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final sortBy = context.select((ConfigCubit cubit) => cubit.sortType);
    final state =
        context.select((LibraryCubit cubit) => cubit.state as LibraryLoaded);
    final sortedMediaItems = state.sortedMediaItems(sortBy);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            stretchTriggerOffset: 10,
            onStretchTrigger: () async {
              LibraryCubit.of(context).toggleAppbarExpanded(true);
            },
            stretch: true,
            expandedHeight: kSliverExpandedHeight,
            pinned: kSliverAppBarPinned,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              final imageHeight = constraints.maxHeight * 0.5;

              final containerHeight = ((constraints.maxHeight -
                          kToolbarHeight -
                          kSliverExpandedHeight) +
                      kFindInPlaylistHeight)
                  .clamp(0, kFindInPlaylistHeight)
                  .toDouble();
              if (containerHeight == 0) {
                LibraryCubit.of(context).toggleAppbarExpanded(false);
              }

              return FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: AnimatedContainer(
                  duration: kThemeAnimationDuration,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: state.gradientColors,
                      stops: const [0, 0.8],
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: kToolbarHeight +
                        (state.isAppbarExpanded ? padding.top : 24),
                  ),
                  child: Column(
                    children: [
                      AnimatedOpacity(
                        duration: kThemeAnimationDuration,
                        opacity: state.isAppbarExpanded
                            ? containerHeight / kFindInPlaylistHeight
                            : 0,
                        child: Container(
                          height: containerHeight,
                          width: context.width * 0.85,
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            height: 32,
                            child: Row(
                              verticalDirection: VerticalDirection.down,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: FindInPlaylist(state: state)),
                                const SizedBox(width: 8),
                                const SortByToggle(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: kThemeAnimationDuration,
                        height: imageHeight,
                        width: imageHeight,
                        child: Image(image: state.image),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          MediaListView.sliver(sortedMediaItems),
        ],
      ),
    );
  }
}
