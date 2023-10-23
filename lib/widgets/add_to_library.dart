import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';

class AddToLibrary extends StatelessWidget {
  final MediaPlaylist playlist;
  final UserLibrary? sourceLibrary;
  const AddToLibrary(this.playlist, {super.key, this.sourceLibrary});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLibraryCubit, UserLibraryState>(
      builder: (context, state) {
        if (state is! UserLibraryLoaded) return const SizedBox.shrink();
        final isInternalLibrary = sourceLibrary?.isDownload == true ||
            sourceLibrary?.isFavorite == true;
        final isAdded = state.isAdded(playlist) || isInternalLibrary;
        return IconButton(
          onPressed: () {
            if (isInternalLibrary) return;
            final cubit = context.read<UserLibraryCubit>();
            if (isAdded) {
              cubit.removeFromLibrary(playlist);
            } else {
              cubit.addToLibrary(playlist);
            }
          },
          icon: isAdded
              ? const Icon(Icons.check_circle_rounded)
              : const Icon(Icons.add_circle_outline_rounded),
          iconSize: 30,
        );
      },
    );
  }
}
