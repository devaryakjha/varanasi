import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/utils/player/audio_handler_impl.dart';

class RepeatToggle extends StatelessWidget {
  const RepeatToggle({
    super.key,
    required this.audioHandler,
  });

  final AudioHandlerImpl audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: audioHandler.playbackState.map((event) => event.repeatMode),
      builder: (context, snapshot) {
        final repeatOn =
            ![null, AudioServiceRepeatMode.none].contains(snapshot.data);
        final icon = {
              AudioServiceRepeatMode.one: const Icon(Icons.repeat_one),
              AudioServiceRepeatMode.all: const Icon(Icons.repeat),
            }[snapshot.data] ??
            const Icon(Icons.repeat);
        return IconButton(
          onPressed: () {
            final nextState = {
                  AudioServiceRepeatMode.none: AudioServiceRepeatMode.one,
                  AudioServiceRepeatMode.one: AudioServiceRepeatMode.all,
                  AudioServiceRepeatMode.all: AudioServiceRepeatMode.none,
                }[snapshot.data ?? AudioServiceRepeatMode.none] ??
                AudioServiceRepeatMode.none;
            context
                .read<MediaPlayerCubit>()
                .audioHandler
                .setRepeatMode(nextState);
          },
          icon: Badge(
            alignment: Alignment.bottomCenter,
            isLabelVisible: repeatOn,
            backgroundColor: context.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: icon,
            ),
          ),
          color: repeatOn ? context.colorScheme.primary : null,
          iconSize: 32,
        );
      },
    );
  }
}
