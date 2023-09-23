import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/utils/player/typings.dart';

class SkipToPrevious extends StatelessWidget {
  const SkipToPrevious({
    super.key,
    required this.queueState,
  });

  final QueueState queueState;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: queueState.hasPrevious
          ? () {
              context.read<MediaPlayerCubit>().skipToPrevious();
            }
          : null,
      icon: const Icon(Icons.skip_previous),
      iconSize: 32,
    );
  }
}
