import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/widgets/play_pause_button.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  late final PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    final (media, isPlaying, queueState) = context.select(
      (MediaPlayerCubit cubit) {
        final queueState = cubit.state.queueState;
        final media = queueState.queue.isNotEmpty
            ? queueState.queue[queueState.queueIndex ?? 0]
            : null;
        return (media, cubit.state.isPlaying, cubit.state.queueState);
      },
    );

    if (media == null) {
      return const SizedBox.shrink();
    }

    Widget buildLeading() {
      return CachedNetworkImage(
        imageUrl: media.artUri.toString(),
        height: 56,
        width: 56,
      );
    }

    Widget buildTitle() {
      return SizedBox(
        height: 24,
        child: PageView.builder(
          controller: _pageController,
          itemCount: queueState.queue.length,
          itemBuilder: (context, index) {
            final media = queueState.queue[index];
            final title = media.displayTitle ?? '';
            return AutoSizeText(
              title,
              key: ValueKey(media.id),
              minFontSize: 16,
              maxFontSize: 16,
              maxLines: 1,
              overflowReplacement: Marquee(
                text: title,
                startAfter: const Duration(seconds: 1),
                pauseAfterRound: const Duration(seconds: 2),
                blankSpace: 8,
                accelerationDuration: const Duration(seconds: 2),
                showFadingOnlyWhenScrolling: true,
                fadingEdgeStartFraction: 0.1,
                fadingEdgeEndFraction: 0.1,
              ),
            );
          },
          onPageChanged: (value) {
            context.read<MediaPlayerCubit>().skipToIndex(value);
          },
        ),
      );
    }

    Widget buildSubtitle() {
      return Text(
        media.displayDescription ?? '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    Widget buildTrailing() {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.skip_previous),
            onPressed: !queueState.hasPrevious
                ? null
                : () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    context.read<MediaPlayerCubit>().skipToPrevious();
                  },
          ),
          PlayPauseMediaButton(
            variant: ButtonVariant.iconbutton,
            onPressed: () {
              if (isPlaying) {
                context.read<MediaPlayerCubit>().pause();
                return;
              }
              context.read<MediaPlayerCubit>().play();
            },
            isPlaying: isPlaying,
          ),
          IconButton(
            icon: const Icon(Icons.skip_next),
            onPressed: !queueState.hasNext
                ? null
                : () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    context.read<MediaPlayerCubit>().skipToNext();
                  },
          ),
        ],
      );
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4),
      leading: buildLeading(),
      title: buildTitle(),
      subtitle: buildSubtitle(),
      trailing: buildTrailing(),
    );
  }
}
