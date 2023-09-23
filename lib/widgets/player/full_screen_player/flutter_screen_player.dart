import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/seek_bar.dart';

class Player extends StatefulWidget {
  const Player({super.key, required this.panelController});
  final PanelController? panelController;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    final controller = context.select((ConfigCubit cubit) =>
        cubit.state is ConfigLoaded
            ? (cubit.state as ConfigLoaded).playerPageController
            : null);
    final (state, audioHandler) = context
        .select((MediaPlayerCubit cubit) => (cubit.state, cubit.audioHandler));
    final queueState = state.queueState;
    final queue = queueState.queue;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => widget.panelController?.close(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
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
            StreamBuilder(
              stream: Rx.combineLatest2(
                audioHandler.player.positionStream,
                audioHandler.mediaItem,
                (a, b) => (a, b),
              ),
              builder: (context, snapshot) {
                final position = snapshot.data?.$1 ?? Duration.zero;
                final media = snapshot.data?.$2;
                return SeekBar(
                  key: ValueKey('${media?.id}seekbar'),
                  color: Colors.white,
                  duration: media?.duration ?? Duration.zero,
                  position: position,
                  onChanged: (value) {
                    context.read<MediaPlayerCubit>().seek(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
