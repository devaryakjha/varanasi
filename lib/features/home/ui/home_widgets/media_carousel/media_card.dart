import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/downloads_icon.dart';
import 'package:varanasi_mobile_app/widgets/music_visualizer.dart';

class MediaCard extends StatelessWidget {
  final PlayableMedia media;
  final bool isFirst, isLast;
  final String heroTagPrefix;
  final VoidCallback? onTap;

  const MediaCard({
    super.key,
    required this.media,
    this.isFirst = false,
    this.isLast = false,
    String? heroTagPrefix,
    this.onTap,
  }) : heroTagPrefix = heroTagPrefix ?? '';

  double get dimension => 120;
  String get title => media.itemTitle;
  String get subtitle => media.itemSubtitle;

  EdgeInsets get padding {
    if (isFirst) {
      return const EdgeInsets.only(left: 8);
    } else if (isLast) {
      return const EdgeInsets.only(right: 8);
    } else {
      return EdgeInsets.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPlaylistSelected = context.select((MediaPlayerCubit value) {
      return value.state.currentPlaylist == media.itemId;
    });
    final isPlaying = context.select((MediaPlayerCubit value) {
      return value.state.isPlaying;
    });
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        final item = media;
        if (item.itemType.isSong) {
          context.read<MediaPlayerCubit>().playFromSong(item);
        } else {
          context.pushNamed(
            AppRoutes.library.name,
            extra: item,
            pathParameters: {'id': item.itemId},
          );
        }
      },
      child: Padding(
        padding: padding,
        child: SizedBox.square(
          dimension: dimension,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Visibility(
                  replacement: DownloadsIcon(dimension: dimension),
                  visible: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: dimension,
                      height: dimension,
                      imageUrl: media.artworkUrl ?? '',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (isPlaylistSelected) ...[
                    MiniMusicVisualizer(
                      key: ValueKey(media.itemId),
                      width: 2,
                      height: 12,
                      animating: isPlaying,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
