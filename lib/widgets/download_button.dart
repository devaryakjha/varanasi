import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:varanasi_mobile_app/cubits/download/download_cubit.dart';
import 'package:varanasi_mobile_app/features/user-library/cubit/user_library_cubit.dart';
import 'package:varanasi_mobile_app/gen/assets.gen.dart';
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
            icon: SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: downloading
                    ? Assets.icon.circularLoader
                        .lottie(width: 36, height: 36, frameRate: FrameRate.max)
                    : switch (downloaded) {
                        true => Assets.icon.downloadFilled,
                        false => Assets.icon.download,
                      }
                        .svg(color: Colors.white),
              ),
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
            icon: switch (downloaded) {
              true => Assets.icon.downloadFilled,
              false when !downloading => Assets.icon.download,
              false => Assets.icon.downloading,
            }
                .svg(color: Colors.white, width: 24),
          );
        });
  }
}
