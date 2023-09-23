import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/player/audio_handler_impl.dart';
import 'package:varanasi_mobile_app/widgets/seek_bar.dart';

class AudioSeekbar extends StatelessWidget {
  const AudioSeekbar({
    super.key,
    required this.audioHandler,
  });

  final AudioHandlerImpl audioHandler;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
          onChangeEnd: (value) {
            context.read<MediaPlayerCubit>().seek(value);
          },
        );
      },
    );
  }
}
