import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';
import 'package:varanasi/app/shared/widgets/media_views/album_card.dart';
import 'package:varanasi/app/shared/widgets/media_views/album_tile.dart';
import 'package:varanasi/app/shared/widgets/media_views/artist_card.dart';
import 'package:varanasi/app/shared/widgets/media_views/playlist_card.dart';
import 'package:varanasi/app/shared/widgets/media_views/song_tile.dart';

const widgetMap = {
  MediaType.artist: ArtistCard.new,
  MediaType.playlist: PlaylistCard.new,
  MediaType.album: AlbumCard.new,
};

const widgetTileMap = {
  MediaType.song: SongTile.new,
  MediaType.album: AlbumTile.new,
};

abstract class MediaCard extends StatelessWidget {
  const MediaCard({
    required this.media,
    super.key,
  });

  factory MediaCard.fromMedia(Media media) {
    return widgetMap[media.type]!(
      media: media,
      key: ValueKey('MediaCard__${media.id}'),
    );
  }

  final Media media;
}

abstract class MediaTile extends StatelessWidget {
  const MediaTile({
    required this.media,
    super.key,
  });

  factory MediaTile.fromMedia(Media media) {
    return widgetTileMap[media.type]!(
      media: media,
      key: ValueKey('MediaTile__${media.id}'),
    );
  }

  final Media media;
}
