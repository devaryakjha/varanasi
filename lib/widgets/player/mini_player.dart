import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/widgets/play_pause_button.dart';
import 'package:varanasi_mobile_app/widgets/player/current_duration.dart';

import 'title.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key, required this.panelController});

  final PanelController? panelController;

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    final (media, isPlaying, queueState, colorPalette) = context.select(
      (MediaPlayerCubit cubit) {
        final state = cubit.state;
        final queueState = state.queueState;
        final media = queueState.queue.isNotEmpty
            ? queueState.queue[queueState.queueIndex ?? 0]
            : null;
        return (
          media,
          state.isPlaying,
          state.queueState,
          cubit.mediaColorPalette
        );
      },
    );

    if (media == null) {
      return const SizedBox.shrink();
    }

    Widget buildLeading() {
      return Card(
        elevation: 24,
        borderOnForeground: false,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: CachedNetworkImage(
          imageUrl: media.artUri.toString(),
          fit: BoxFit.cover,
        ),
      );
    }

    Widget buildTrailing() {
      return PlayPauseMediaButton(
        foregroundColor: colorPalette?.foregroundColor,
        variant: ButtonVariant.iconbutton,
        onPressed: () {
          if (isPlaying) {
            context.read<MediaPlayerCubit>().pause();
            return;
          }
          context.read<MediaPlayerCubit>().play();
        },
        isPlaying: isPlaying,
      );
    }

    return GestureDetector(
      onTap: () => widget.panelController?.open(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: colorPalette?.backgroundColor ?? context.theme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8).copyWith(left: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildLeading(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Title(
                      key: ValueKey('${media.id}pageview'),
                      queueState: queueState,
                      colorPalette: colorPalette,
                    ),
                  ),
                  buildTrailing(),
                ],
              ),
            ),
            CurrentDuration(media: media, colorPalette: colorPalette),
          ],
        ),
      ),
    );
  }
}
