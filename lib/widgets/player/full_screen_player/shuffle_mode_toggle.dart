import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
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
    final shuffleMode = context.select((ConfigCubit cubit) =>
        AudioServiceShuffleMode
            .values[(cubit.state as ConfigLoaded).config.shuffleMode]);

    final shuffleEnabled =
        ![null, AudioServiceShuffleMode.none].contains(shuffleMode);
    return IconButton(
      onPressed: () {
        final nextMode = switch (shuffleMode) {
          AudioServiceShuffleMode.none => AudioServiceShuffleMode.all,
          AudioServiceShuffleMode.all => AudioServiceShuffleMode.none,
          _ => AudioServiceShuffleMode.none,
        };
        context.read<MediaPlayerCubit>().audioHandler.setShuffleMode(nextMode);
        // TODO (Arya): figure out how to restore shuffle order
        // context.read<ConfigCubit>().saveShuffleMode(nextMode.index);
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
  }
}
