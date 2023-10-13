// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';

enum PlayableMediaType {
  song(1),
  album(2),
  playlist(3),
  artist(4);

  const PlayableMediaType(this.value);

  factory PlayableMediaType.fromString(String type) => switch (type) {
        'album' => PlayableMediaType.album,
        'playlist' => PlayableMediaType.playlist,
        'artist' => PlayableMediaType.artist,
        _ => PlayableMediaType.song
      };

  final int value;

  bool get isSong => this == PlayableMediaType.song;
  bool get isAlbum => this == PlayableMediaType.album;
  bool get isPlaylist => this == PlayableMediaType.playlist;
  bool get isArtist => this == PlayableMediaType.artist;
}

abstract class PlayableMedia extends Equatable {
  String get itemTitle;
  String get itemUrl;
  String get itemId;
  String get heroTag => itemId;
  String get itemSubtitle;

  bool get preferLinkOverId => false;

  PlayableMediaType get itemType;
  String? get artworkUrl;

  const PlayableMedia();

  @override
  List<Object?> get props => [
        itemId,
        itemTitle,
        itemSubtitle,
        itemUrl,
        itemType,
        artworkUrl,
      ];

  /// {@template toMediaItem}
  /// Converts the [PlayableMedia] to a [MediaItem] for use with [AudioService].
  /// {@endtemplate}
  MediaItem toMediaItem() {
    var duration = Duration.zero;
    var album = '';
    var artist = '';
    var id = itemUrl;

    if (this is Song) {
      final song = (this as Song);
      duration = Duration(seconds: int.parse((song.duration ?? '0')));
      album = song.album?.name ?? '';
      final artists = song.featuredArtists ?? song.primaryArtists ?? [];
      artist = artists.map((e) => e.name ?? '').join(', ');
      final isDataSaverEnabled =
          AppConfig.getBox.get(0)?.isDataSaverEnabled ?? false;
      final effectiveQuality = AppConfig.getBox.get(0)?.downloadQuality ??
          (isDataSaverEnabled ? DownloadQuality.low : DownloadQuality.extreme);

      id = song.downloadUrl
              ?.firstWhereOrNull((e) => e.quality == effectiveQuality)
              ?.link ??
          '';
    }

    return MediaItem(
      id: id,
      title: itemTitle,
      artist: artist,
      displayTitle: itemTitle,
      displaySubtitle: itemSubtitle,
      displayDescription: itemSubtitle,
      album: album,
      artUri: Uri.parse(artworkUrl ?? ''),
      duration: duration,
    );
  }

  /// {@template getMoreInfoUrl}
  /// Returns a [Uri] to the more info page at the backend for the [PlayableMedia].
  /// {@endtemplate}
  Uri get moreInfoUrl {
    return switch (itemType) {
      PlayableMediaType.song when !preferLinkOverId => Uri.parse(
          '${appConfig.endpoint.songs!.id}?id=$itemId&language=hindi,english',
        ),
      PlayableMediaType.song => Uri.parse(
          '${appConfig.endpoint.songs!.link}?link=${Uri.encodeComponent(itemUrl)}&language=hindi,english',
        ),
      PlayableMediaType.album => Uri.parse(
          '${appConfig.endpoint.albums!.link}?link=$itemUrl&language=hindi,english',
        ),
      PlayableMediaType.playlist => Uri.parse(
          '${appConfig.endpoint.playlists!.id}?id=$itemId&language=hindi,english',
        ),
      PlayableMediaType.artist => Uri.parse(
          '${appConfig.endpoint.artists?.id}?id=$itemId&language=hindi,english',
        ),
    };
  }

  /// {@template getCacheKey}
  /// Returns a unique key for the [PlayableMedia] to be used in the cache.
  /// {@endtemplate}
  String get cacheKey => '$itemId-${describeEnum(itemType)}';

  MediaPlaylist<T> toMediaPlaylist<T extends PlayableMedia>() {
    return MediaPlaylist<T>(
      title: itemTitle,
      description: itemSubtitle,
      id: itemId,
      mediaItems: [this as T],
    );
  }
}
