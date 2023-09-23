import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/utils/player/audio_handler_impl.dart';

class ShuffleModeToggle extends StatelessWidget {
  const ShuffleModeToggle({
    super.key,
    required this.audioHandler,
  });

  final AudioHandlerImpl audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioHandler.playbackState.map((event) => event.shuffleMode),
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
            backgroundColor: context.colorScheme.primary,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Icon(Icons.shuffle),
            ),
          ),
          color: shuffleEnabled ? context.colorScheme.primary : null,
          iconSize: 32,
        );
      },
    );
  }
}
