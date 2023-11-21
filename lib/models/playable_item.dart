// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/models/album.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';

enum PlayableMediaType {
  song(1),
  album(2),
  playlist(3),
  artist(4),
  download(5);

  const PlayableMediaType(this.value);

  factory PlayableMediaType.fromString(String type) => switch (type) {
        'album' => PlayableMediaType.album,
        'playlist' => PlayableMediaType.playlist,
        'artist' => PlayableMediaType.artist,
        'download' => PlayableMediaType.download,
        'downloads' => PlayableMediaType.download,
        _ => PlayableMediaType.song
      };

  final int value;

  bool get isSong => this == PlayableMediaType.song;
  bool get isAlbum => this == PlayableMediaType.album;
  bool get isPlaylist => this == PlayableMediaType.playlist;
  bool get isArtist => this == PlayableMediaType.artist;
  bool get isDownload => this == PlayableMediaType.download;
}

abstract class PlayableMedia extends Equatable {
  String get itemTitle;
  String get itemUrl;
  String get itemId;
  String get heroTag => itemId;
  String get itemSubtitle;

  bool get preferLinkOverId {
    if (itemType.isSong) {
      if (itemUrl.contains('.mp4')) {
        return false;
      }
      return itemUrl.isNotEmpty;
    }
    return (itemType.isSong || itemType.isAlbum) && itemUrl.isNotEmpty;
  }

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
      final effectiveQuality = AppConfig.getBox.get(0)?.streamingQuality ??
          (isDataSaverEnabled ? DownloadQuality.low : DownloadQuality.extreme);

      id = song.downloadUrl
              ?.firstWhereOrNull((e) => e.dQuality == effectiveQuality)
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
      extras: {
        'itemType': itemType.name,
        'itemId': itemId,
        'itemUrl': itemUrl,
        'itemTitle': itemTitle,
        'itemSubtitle': itemSubtitle,
        'artworkUrl': artworkUrl,
      },
    );
  }

  /// {@template getMoreInfoUrl}
  /// Returns a [Uri] to the more info page at the backend for the [PlayableMedia].
  /// {@endtemplate}
  Uri get moreInfoUrl {
    return switch (itemType) {
      PlayableMediaType.song when !preferLinkOverId =>
        Uri.parse('${appConfig.endpoint.songs!.id}?id=$itemId'),
      PlayableMediaType.song => Uri.parse(
          '${appConfig.endpoint.songs!.link}?link=${Uri.encodeComponent(itemUrl)}',
        ),
      PlayableMediaType.album when preferLinkOverId =>
        Uri.parse('${appConfig.endpoint.albums!.link}?link=$itemUrl'),
      PlayableMediaType.album =>
        Uri.parse('${appConfig.endpoint.albums!.id}?id=$itemId'),
      PlayableMediaType.playlist =>
        Uri.parse('${appConfig.endpoint.playlists!.id}?id=$itemId'),
      PlayableMediaType.artist =>
        Uri.parse('${appConfig.endpoint.artists?.id}?id=$itemId'),
      PlayableMediaType.download => Uri.parse(''),
    };
  }

  /// {@template getCacheKey}
  /// Returns a unique key for the [PlayableMedia] to be used in the cache.
  /// {@endtemplate}
  String get cacheKey => '$itemId-${itemType.name}';

  MediaPlaylist toMediaPlaylist() {
    return MediaPlaylist(
      title: itemTitle,
      description: itemSubtitle,
      id: itemId,
      mediaItems: [this],
      images: switch (this) {
        (Song song) => song.image ?? const [],
        (Album album) => album.image ?? const [],
        (Playlist playlist) => playlist.image ?? const [],
        (_) => const [],
      },
      url: itemUrl,
      type: itemType.name,
    );
  }

  Map<String, dynamic> toJson();
}
