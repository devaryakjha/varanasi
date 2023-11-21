import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/library/cubit/library_cubit.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

class LibraryDetailPage extends StatelessWidget {
  final String id;
  final PlayableMedia media;
  const LibraryDetailPage(this.id, this.media, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: FutureBuilder(
        future: LibraryRepository.instance.fetchLibrary(media),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final mediaItems = snapshot.data?.mediaItems ?? [];
          final state = context.select((LibraryCubit cubit) => cubit.state[id]);
          if (state is! MediaLoadedState) {
            return const Center(child: CircularProgressIndicator());
          }
          final selectedPlaylist = state.playlist;
          final (appendItemToLibrary, removeItemFromLibrary) = context.select(
            (UserLibraryCubit cubit) => (
              (Song item) => cubit.appendItemToLibrary(selectedPlaylist, item),
              (Song item) =>
                  cubit.removeItemFromLibrary(selectedPlaylist, item),
            ),
          );
          return MediaListView(
            mediaItems,
            isPlaying: false,
            isItemPlaying: (media) => false,
            trailing: (media) {
              final isAdded = (selectedPlaylist.mediaItems ?? [])
                  .any((item) => item.itemId == media.itemId);
              return IconButton(
                onPressed: () {
                  if (!isAdded) {
                    appendItemToLibrary(media);
                  } else {
                    removeItemFromLibrary(media);
                  }
                },
                icon: isAdded
                    ? const Icon(Icons.check_circle_rounded)
                    : const Icon(Icons.add_circle_outline_rounded),
                iconSize: 30,
              );
            },
          );
        },
      ),
    );
  }
}
