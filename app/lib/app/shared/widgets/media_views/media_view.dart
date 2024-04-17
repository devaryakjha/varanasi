import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';
import 'package:varanasi/app/shared/widgets/media_views/artist_card.dart';

class MediaView extends StatelessWidget {
  const MediaView({
    required this.media,
    super.key,
  });

  final Media media;

  @override
  Widget build(BuildContext context) {
    return switch (media.type) {
      MediaType.artist => ArtistCard(media: media),
    };
  }
}
