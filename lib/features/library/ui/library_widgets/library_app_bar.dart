import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/find_in_playlist.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/sort_by_toggle.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/constants/dimensions.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';

class LibraryAppBar extends StatelessWidget {
  const LibraryAppBar({
    super.key,
    required this.state,
    required this.padding,
  });

  final LibraryLoaded<PlayableMedia> state;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 10,
      stretch: true,
      expandedHeight: kSliverExpandedHeight,
      pinned: kSliverAppBarPinned,
      collapsedHeight: kToolbarHeight,
      flexibleSpace: LayoutBuilder(builder: (context, constraints) {
        final imageHeight = constraints.maxHeight * 0.5;

        final containerHeight =
            ((constraints.maxHeight - kToolbarHeight - kSliverExpandedHeight) +
                    kFindInPlaylistHeight)
                .clamp(0, kFindInPlaylistHeight)
                .toDouble();
        if (state.needSearchBar) {
          if (containerHeight == 0 ||
              constraints.maxHeight == kSliverExpandedHeight) {
            LibraryCubit.of(context).toggleAppbarExpanded(false);
          }

          if (constraints.maxHeight > 440) {
            LibraryCubit.of(context).toggleAppbarExpanded(true);
          }
        }

        return AnimatedContainer(
          duration: kThemeAnimationDuration,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: state.gradientColors,
              stops: const [0, 0.8],
            ),
          ),
          child: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            background: AnimatedContainer(
              duration: kThemeAnimationDuration,
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
                    decoration: BoxDecoration(boxShadow: state.boxShadow),
                    child: Image(
                      height: imageHeight,
                      width: imageHeight,
                      image: state.image,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
