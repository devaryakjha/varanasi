import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/download/download_cubit.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton(this.song, {super.key});

  final PlayableMedia song;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DownloadedMedia?>(
        stream: context.select((DownloadCubit value) => value.listen(song)),
        builder: (context, snapshot) {
          final data = snapshot.data;
          final downloaded = data?.downloadComplete ?? false;
          final downloading = data?.downloading ?? false;

          return IconButton(
            onPressed: () {
              final cubit = context.read<DownloadCubit>();
              if (downloaded) {
                cubit.deleteDownloadedMedia(song);
              } else if (downloading) {
                cubit.cancelDownload(song);
              } else {
                cubit.downloadSong(song);
              }
            },
            icon: Icon(
              downloading
                  ? Icons.downloading_rounded
                  : downloaded
                      ? Icons.delete_outline_rounded
                      : Icons.download_outlined,
            ),
            color: context.colorScheme.onBackground,
          );
        });
  }
}

class DownloadPlaylist extends StatelessWidget {
  final MediaPlaylist playlist;
  const DownloadPlaylist({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    final stream = context
        .select((DownloadCubit cubit) => cubit.listenToPlaylist(playlist));
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          final downloading = snapshot.data?.downloading ?? false;
          final downloaded = snapshot.data?.downloaded ?? false;
          return IconButton(
            onPressed: () {
              context.read<DownloadCubit>().batchDownload(playlist);
            },
            icon: Icon(
              downloading
                  ? Icons.downloading_rounded
                  : downloaded
                      ? Icons.delete_outline_rounded
                      : Icons.download_outlined,
            ),
          );
        });
  }
}
