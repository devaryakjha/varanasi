import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

class LibrarySearchPage extends HookWidget {
  final MediaPlaylist playlist;
  const LibrarySearchPage({
    super.key,
    required this.playlist,
  });

  List<PlayableMedia> get media => playlist.mediaItems ?? [];

  String get playlistId => playlist.id;

  @override
  Widget build(BuildContext context) {
    final filteredMedia = useState(media);

    final (currentPlaylist, currentMediaItem, isPlaying) =
        context.select((MediaPlayerCubit cubit) {
      return (
        cubit.state.currentPlaylist,
        cubit.state.currentMediaItem,
        cubit.state.isPlaying,
      );
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: CupertinoSearchTextField(
                placeholder: 'Find in playlist',
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  final results = extractAllSorted(
                    query: value,
                    choices: media,
                    getter: (obj) => obj.itemTitle,
                  );
                  filteredMedia.value = results.map((e) => e.choice).toList();
                },
              ),
            ),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: MediaListView(
        filteredMedia.value,
        isPlaying: isPlaying,
        isItemPlaying: (p0) => currentMediaItem == p0.toMediaItem(),
        onItemTap: (index, media) {
          if (currentPlaylist == playlistId) {
            context.readMediaPlayerCubit.skipToMediaItem(media);
          } else {
            context.readMediaPlayerCubit.playFromMediaPlaylist(playlist);
          }
        },
      ),
    );
  }
}
