import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/cubits/download/download_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton(this.media, {super.key});

  final PlayableMedia media;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DownloadedMedia?>(
        stream: context.select((DownloadCubit value) => value.listen(media)),
        builder: (context, snapshot) {
          final data = snapshot.data;
          final downloaded = data?.downloadComplete ?? false;
          final downloading = data?.downloading ?? false;
          final progress = data?.progress ?? 0;

          return IconButton(
            onPressed: () {
              final cubit = context.read<DownloadCubit>();
              if (downloaded) {
                cubit.deleteDownloadedMedia(media);
              } else if (downloading) {
                cubit.cancelDownload(media);
              } else {
                cubit.downloadSong(media);
              }
              HapticFeedback.mediumImpact();
            },
            icon: DownloadStatus(
              downloading: downloading,
              progress: progress,
              downloaded: downloaded,
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
    final progress = context.select((DownloadCubit value) =>
        value.state.playlistProgressMap[playlist.id] ?? 0);
    final downloadBox = context.read<DownloadCubit>().downloadBox;
    final keys = playlist.mediaItems?.map((e) => e.itemId).toList();
    return ValueListenableBuilder(
        valueListenable: downloadBox.listenable(keys: keys),
        builder: (context, box, _) {
          final values = keys?.map((key) => box.get(key)).toList() ?? [];
          final downloading =
              values.any((element) => element?.downloading ?? false);
          final downloaded =
              !values.any((element) => !(element?.downloadComplete ?? false));
          return IconButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              final cubit = context.read<DownloadCubit>();
              if (downloading) {
                cubit.batchCancel(playlist);
                return;
              }
              if (downloaded) {
                cubit.batchDelete(playlist);
                return;
              }
              context.read<UserLibraryCubit>().addToLibrary(playlist);
              cubit.batchDownload(playlist);
            },
            icon: DownloadStatus(
              downloading: downloading,
              downloaded: downloaded,
              progress: progress,
            ),
            iconSize: 24,
          );
        });
  }
}

class DownloadStatus extends StatelessWidget {
  const DownloadStatus({
    super.key,
    required this.downloading,
    required this.progress,
    this.dimension = 22,
    required this.downloaded,
  });

  final bool downloading;
  final bool downloaded;
  final double progress;
  final double dimension;

  double get iconSize => dimension * 0.6;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Visibility(
        visible: !downloaded,
        replacement: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            Icons.arrow_downward_rounded,
            color: Colors.black,
            size: iconSize,
          ),
        ),
        child: Stack(
          children: [
            if (downloading)
              CircularProgressIndicator(
                strokeWidth: 2,
                value: downloading ? progress : 1,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.white.withOpacity(0.3),
              ),
            if (!downloading)
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.fromBorderSide(
                    BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            Positioned.fill(
              child: Icon(
                downloading ? Icons.stop_rounded : Icons.arrow_downward_rounded,
                color: Colors.white,
                size: iconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
