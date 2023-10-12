// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';

enum PlayableMediaType {
  song(1),
  album(2),
  playlist(3);

  const PlayableMediaType(this.value);

  factory PlayableMediaType.fromString(String type) => switch (type) {
        'album' => PlayableMediaType.album,
        'playlist' => PlayableMediaType.playlist,
        _ => PlayableMediaType.song
      };

  final int value;

  bool get isSong => this == PlayableMediaType.song;
  bool get isAlbum => this == PlayableMediaType.album;
  bool get isPlaylist => this == PlayableMediaType.playlist;
}

abstract class PlayableMedia extends Equatable {
  String get itemTitle;
  String get itemUrl;
  String get itemId;
  String get itemSubtitle;
  PlayableMediaType get itemType;
  String? get artworkUrl;

  const PlayableMedia();

  @override
  List<Object?> get props {
    return [itemId, itemTitle, itemSubtitle, itemUrl, itemType, artworkUrl];
  }

  /// {@template toMediaItem}
  /// Converts the [PlayableMedia] to a [MediaItem] for use with [AudioService].
  /// {@endtemplate}
  MediaItem toMediaItem() {
    var duration = Duration.zero;
    var album = '';
    var artist = '';

    if (this is Song) {
      final song = (this as Song);
      duration = Duration(seconds: int.parse((song.duration ?? '0')));
      album = song.album?.name ?? '';
      final artists = song.featuredArtists ?? song.primaryArtists ?? [];
      artist = artists.map((e) => e.name ?? '').join(', ');
    }

    return MediaItem(
      id: itemUrl,
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
      PlayableMediaType.song =>
        Uri.parse('${appConfig.endpoint.songs!.id}?id=$itemId'),
      PlayableMediaType.album => Uri.parse(
          '${appConfig.endpoint.albums!.link}?link=$itemUrl&language=hindi,english'),
      PlayableMediaType.playlist => Uri.parse(
          '${appConfig.endpoint.playlists!.id}?id=$itemId&language=hindi,english'),
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
