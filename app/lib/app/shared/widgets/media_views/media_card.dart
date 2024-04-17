import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';
import 'package:varanasi/app/shared/widgets/media_views/artist_card.dart';
import 'package:varanasi/app/shared/widgets/media_views/playlist_card.dart';

const widgetMap = {
  MediaType.artist: ArtistCard.new,
  MediaType.playlist: PlaylistCard.new,
};

abstract class MediaCard extends StatelessWidget {
  const MediaCard({
    required this.media,
    super.key,
  });

  factory MediaCard.fromMedia(Media media) {
    return widgetMap[media.type]!(media: media);
  }

  final Media media;
}
