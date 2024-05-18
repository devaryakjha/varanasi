import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';
import 'package:varanasi/varanasi.dart';

class SongTile extends MediaTile {
  const SongTile({
    required super.media,
    super.key,
  });

  @override
  VoidCallbackWith<BuildContext> get onTap =>
      (context) => MediaDetailRouteData.song(
            id: media.token,
            image: media.highestQualityImage,
            title: media.title,
            subtitle: media.subTitle,
          ).push<void>(context);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(context),
      dense: true,
      leading: SizedBox.square(
        dimension: 48,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: media.highestQualityImage,
          ),
        ),
      ),
      title: Text(media.title),
      subtitle: Text(
        media.subTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
