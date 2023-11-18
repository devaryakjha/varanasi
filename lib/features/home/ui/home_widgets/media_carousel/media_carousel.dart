import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

import 'media_card.dart';

class MediaCarousel extends StatelessWidget {
  final MediaPlaylist playlist;
  final ValueChanged<int>? onItemTap;

  const MediaCarousel({
    super.key,
    required this.playlist,
    this.onItemTap,
  });

  int get totalItems => playlist.mediaItems?.length ?? 0;
  String get title => playlist.title ?? '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              scrollDirection: Axis.horizontal,
              itemCount: totalItems,
              itemBuilder: (context, index) {
                final media = playlist.mediaItems![index];
                final heroTagPrefix = media.heroTag;
                return MediaCard(
                  key: ValueKey(media.itemId),
                  heroTagPrefix: heroTagPrefix,
                  media: media,
                  isFirst: index == 0,
                  isLast: index == totalItems - 1,
                  onTap: onItemTap != null ? () => onItemTap!(index) : null,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
