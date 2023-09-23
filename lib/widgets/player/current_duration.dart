import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';

class CurrentDuration extends StatelessWidget {
  const CurrentDuration({
    super.key,
    required this.media,
    required this.colorPalette,
  });

  final MediaItem? media;
  final MediaColorPalette? colorPalette;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 8,
      right: 8,
      bottom: 0.5,
      child: StreamBuilder(
        stream: AudioService.position,
        builder: (context, snapshot) {
          return LinearProgressIndicator(
            value: snapshot.hasData
                ? snapshot.data!.inMilliseconds /
                    media!.duration!.inMilliseconds
                : 0,
            minHeight: 1.5,
            color: colorPalette?.foregroundColor,
            backgroundColor: colorPalette?.foregroundColor?.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          );
        },
      ),
    );
  }
}
