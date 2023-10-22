import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/widgets/download_button.dart';
import 'package:varanasi_mobile_app/widgets/favorite_button.dart';

class MediaInfo extends StatelessWidget {
  const MediaInfo({
    super.key,
    required this.mediaItem,
    required this.currentMedia,
  });

  final MediaItem mediaItem;
  final PlayableMedia? currentMedia;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      title: Text(
        mediaItem.displayTitle ?? '',
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        mediaItem.displaySubtitle ?? '',
        style:
            context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentMedia != null) DownloadButton(currentMedia!),
          FavoriteButton(media: currentMedia),
        ],
      ),
    );
  }
}
