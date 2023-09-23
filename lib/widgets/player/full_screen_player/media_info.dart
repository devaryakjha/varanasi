import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';

class MediaInfo extends StatelessWidget {
  const MediaInfo({
    super.key,
    required this.mediaItem,
  });

  final MediaItem mediaItem;

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
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add_circle_outline_rounded),
        iconSize: 32,
      ),
    );
  }
}
