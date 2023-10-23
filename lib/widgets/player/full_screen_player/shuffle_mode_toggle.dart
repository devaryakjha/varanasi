import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';

class ShuffleModeToggle extends StatelessWidget {
  const ShuffleModeToggle({
    super.key,
    this.iconSize = 32,
  });

  final double iconSize;

  double get smallSize => iconSize * 0.18;

  @override
  Widget build(BuildContext context) {
    final audioHandler = context.read<MediaPlayerCubit>().audioHandler;
    return StreamBuilder(
      stream: audioHandler.playbackState.map((event) => event.shuffleMode),
      initialData: AudioServiceShuffleMode.none,
      builder: (context, snapshot) {
        final shuffleEnabled =
            ![null, AudioServiceShuffleMode.none].contains(snapshot.data);
        return IconButton(
          onPressed: () {
            final nextMode = {
                  AudioServiceShuffleMode.none: AudioServiceShuffleMode.all,
                  AudioServiceShuffleMode.all: AudioServiceShuffleMode.none,
                }[snapshot.data ?? AudioServiceShuffleMode.none] ??
                AudioServiceShuffleMode.none;
            context
                .read<MediaPlayerCubit>()
                .audioHandler
                .setShuffleMode(nextMode);
          },
          icon: Badge(
            alignment: Alignment.bottomCenter,
            isLabelVisible: shuffleEnabled,
            smallSize: smallSize,
            child: Assets.icon.shuffle.svg(
              width: iconSize,
              height: iconSize,
              color:
                  shuffleEnabled ? context.colorScheme.primary : Colors.white,
            ),
          ),
          color: shuffleEnabled ? context.colorScheme.primary : null,
          iconSize: iconSize,
        );
      },
    );
  }
}
