import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Typography;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/ui/library_widgets/library_app_bar.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/add_to_library.dart';
import 'package:varanasi_mobile_app/widgets/disable_child.dart';
import 'package:varanasi_mobile_app/widgets/download_button.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';
import 'package:varanasi_mobile_app/widgets/play_pause_button.dart';
import 'package:varanasi_mobile_app/widgets/player/full_screen_player/shuffle_mode_toggle.dart';

class LibraryContent extends StatefulHookWidget {
  /// The source of the library content
  final PlayableMedia? source;

  const LibraryContent({
    super.key,
    required this.source,
  });

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> {
  late final ScrollController _scrollController;
  final titleKey = GlobalKey(debugLabel: 'titleKey');

  /// position of the floating action button
  double top = 0.0;
  double right = 16.0;

  late final double minimumValueForFab;

  void updateFABPosition() {
    /// calculate the position of the floating action button
    /// based on titleKey position
    final RenderBox? renderBox =
        titleKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final offset = renderBox.localToGlobal(Offset.zero);
      setState(() {
        final size = renderBox.size;
        final kTop = offset.dy + ((size.height - 60) / 2);
        top = kTop.clamp(minimumValueForFab, 10000);
      });
      LibraryCubit.of(context)
          .toggleAppbarTitle(top <= minimumValueForFab + 16);
    }
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(updateFABPosition);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      minimumValueForFab = context.topPadding + kToolbarHeight - 36;
      updateFABPosition();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(updateFABPosition);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;

    final sortBy = context.select((ConfigCubit cubit) => cubit.sortType);
    final state =
        context.select((LibraryCubit cubit) => cubit.state as LibraryLoaded);
    final sortedMediaItems = state.sortedMediaItems(sortBy);

    final (currentPlaylist, currentMediaItem, isPlaying) =
        context.select((MediaPlayerCubit cubit) {
      return (
        cubit.state.currentPlaylist,
        cubit.state.currentMediaItem,
        cubit.state.isPlaying,
      );
    });

    final isPlaylistSelected = currentPlaylist == state.playlist.id;

    final isThisPlaylistPlaying =
        currentPlaylist == state.playlist.id && isPlaying;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverStack(
            insetOnOverlap: true,
            children: [
              MultiSliver(
                children: [
                  LibraryAppBar(state: state, padding: padding),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ).copyWith(right: 84),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.title,
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(state.subtitle),
                          Row(
                            key: titleKey,
                            children: [
                              AddToLibrary(
                                state.playlist,
                                sourceLibrary: state.sourceLibrary,
                              ),
                              DisableChild(
                                disabled: !kDebugMode &&
                                    state.sourceLibrary?.isDownload == true,
                                child: DownloadPlaylist(
                                  playlist: state.playlist,
                                ),
                              ),
                              const Spacer(),
                              const ShuffleModeToggle(iconSize: 24),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  MediaListView.sliver(
                    sortedMediaItems,
                    mediaType: widget.source?.itemType,
                    isPlaying: isThisPlaylistPlaying,
                    isItemPlaying: (media) {
                      return media.toMediaItem() == currentMediaItem;
                    },
                    onItemTap: (index, mediaItem) {
                      if (isPlaylistSelected) {
                        context.readMediaPlayerCubit.skipToMediaItem(mediaItem);
                      } else {
                        context.readMediaPlayerCubit.playFromMediaPlaylist(
                          state.playlist.copyWith(mediaItems: sortedMediaItems),
                          initialMedia: mediaItem,
                        );
                      }
                    },
                    itemSelectedColor: state
                        .colorPalette.lightVibrantColor?.color
                        .withOpacity(1),
                  ),
                ],
              ),
              SliverPositioned(
                top: top,
                right: right,
                child: PlayPauseMediaButton(
                  backgroundColor: state.colorPalette.vibrantColor?.color,
                  foregroundColor: state
                      .colorPalette.vibrantColor?.bodyTextColor
                      .withOpacity(1),
                  onPressed: () {
                    if (isThisPlaylistPlaying) {
                      context.readMediaPlayerCubit.pause();
                      return;
                    }
                    context.readMediaPlayerCubit.playFromMediaPlaylist(
                      state.playlist.copyWith(mediaItems: sortedMediaItems),
                    );
                  },
                  isPlaying: isThisPlaylistPlaying,
                  size: 36,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
