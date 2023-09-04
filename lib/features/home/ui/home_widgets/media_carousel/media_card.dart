import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';

class MediaCard extends StatelessWidget {
  final PlayableMedia media;
  final bool isFirst, isLast;

  const MediaCard({
    super.key,
    required this.media,
    this.isFirst = false,
    this.isLast = false,
  });

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
    return Hero(
      tag: media.itemId,
      child: GestureDetector(
        onTap: switch (media.itemType) {
          PlayableMediaType.song => () {},
          _ => () => context.push(AppRoutes.library.path, extra: media),
        },
        child: Padding(
          padding: padding,
          child: SizedBox.square(
            dimension: dimension,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                const SizedBox(height: 8),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.labelLarge,
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
      ),
    );
  }
}
