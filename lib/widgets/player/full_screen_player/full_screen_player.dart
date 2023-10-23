import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/play_pause_button.dart';

import 'audio_seekbar.dart';
import 'media_info.dart';
import 'repeat_toggle.dart';
import 'shuffle_mode_toggle.dart';
import 'skip_to_next.dart';
import 'skip_to_previous.dart';

class Player extends StatefulWidget {
  const Player({super.key, required this.panelController});
  final PanelController? panelController;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    final controller = context.select(
      (ConfigCubit cubit) => cubit.state is ConfigLoaded
          ? cubit.configLoadedState.playerPageController
          : null,
    );
    final currentMedia = context.select(
      (ConfigCubit cubit) => cubit.state is ConfigLoaded
          ? cubit.configLoadedState.currentMedia
          : null,
    );
    final (state, audioHandler) = context
        .select((MediaPlayerCubit cubit) => (cubit.state, cubit.audioHandler));
    final queueState = state.queueState;
    final queue = queueState.queue;
    final mediaItem = queue[queueState.queueIndex ?? 0];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => widget.panelController?.close(),
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 32,
        ),
      ),
      body: AnimatedContainer(
        padding: EdgeInsets.only(top: kToolbarHeight + context.topPadding),
        width: context.width,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(gradient: state.gradient),
        child: Column(
          children: [
            SizedBox.square(
              dimension: context.width,
              child: CarouselSlider.builder(
                carouselController: controller,
                itemCount: queue.length,
                itemBuilder: (context, index, _) {
                  final media = queue[index];
                  return Padding(
                    key: ValueKey(media.id),
                    padding: EdgeInsets.all(context.width * 0.05),
                    child: CachedNetworkImage(
                      imageUrl: media.artUri.toString(),
                    ),
                  );
                },
                options: CarouselOptions(
                  initialPage: queueState.queueIndex ?? 0,
                  height: context.width,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  onPageChanged: (index, reason) {
                    if (reason == CarouselPageChangedReason.manual) {
                      context.read<MediaPlayerCubit>().skipToIndex(index);
                    }
                  },
                ),
              ),
            ),
            MediaInfo(mediaItem: mediaItem, currentMedia: currentMedia),
            AudioSeekbar(audioHandler: audioHandler),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const ShuffleModeToggle(),
                SkipToPrevious(queueState: queueState),
                PlayPauseMediaButton(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    if (state.isPlaying) {
                      context.read<MediaPlayerCubit>().pause();
                    } else {
                      context.read<MediaPlayerCubit>().play();
                    }
                  },
                  isPlaying: state.isPlaying,
                ),
                SkipToNext(queueState: queueState),
                RepeatToggle(audioHandler: audioHandler),
              ],
            )
          ],
        ),
      ),
    );
  }
}
