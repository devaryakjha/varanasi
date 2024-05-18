import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';
import 'package:varanasi/varanasi.dart';

class AlbumCard extends MediaCard {
  const AlbumCard({
    required super.media,
    super.key,
  });

  @override
  VoidCallbackWith<BuildContext> get onTap =>
      (context) => MediaDetailRouteData.album(
            id: media.token,
            image: media.highestQualityImage,
            title: media.title,
            subtitle: media.subTitle,
          ).push<void>(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: SizedBox(
        height: media.height,
        width: media.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox.square(
              dimension: media.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: media.highestQualityImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(8),
            Expanded(
              child: Text(
                media.title,
                style: context.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
