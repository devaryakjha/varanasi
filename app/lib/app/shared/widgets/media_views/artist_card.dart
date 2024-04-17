import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';

class ArtistCard extends MediaCard {
  const ArtistCard({
    required super.media,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: media.width,
      height: media.height,
      child: Column(
        children: [
          CircleAvatar(
            radius: media.width / 2,
            backgroundImage: CachedNetworkImageProvider(
              media.highestQualityImage,
            ),
          ),
          const Gap(8),
          Text(
            media.title,
            style: context.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
