import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';

class SongTile extends MediaTile {
  const SongTile({
    required super.media,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      dense: true,
      leading: SizedBox.square(
        dimension: 48,
        child: CachedNetworkImage(
          imageUrl: media.highestQualityImage,
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
