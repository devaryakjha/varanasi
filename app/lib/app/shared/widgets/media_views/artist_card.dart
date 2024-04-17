import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({
    required this.media,
    super.key,
  });

  final Media media;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: media.width,
      height: media.height,
      child: Column(
        children: [
          CircleAvatar(
            radius: media.width / 2,
            backgroundImage: NetworkImage(media.highestQualityImage),
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
