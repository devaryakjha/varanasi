import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';
import 'package:varanasi/core/routing/routes.dart';

class ArtistCard extends MediaCard {
  const ArtistCard({
    required super.media,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MediaDetailRouteData.artist(
          id: media.token,
          image: media.highestQualityImage,
        ).push<void>(context);
      },
      child: SizedBox(
        width: media.width,
        height: media.height,
        child: Column(
          children: [
            Hero(
              tag: media.token,
              transitionOnUserGestures: true,
              child: CircleAvatar(
                radius: media.width / 2,
                backgroundImage: CachedNetworkImageProvider(
                  cacheKey: media.token,
                  media.highestQualityImage,
                ),
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
      ),
    );
  }
}
