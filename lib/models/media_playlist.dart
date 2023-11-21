// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

import 'song.dart';

part 'media_playlist.g.dart';

enum MediaPlaylistType {
  song('song'),
  favorite('favorite'),
  album('album'),
  playlist('playlist'),
  download('download'),
  customPlaylist('custom_playlist');
  // TODO: Add Artist

  final String type;

  const MediaPlaylistType(this.type);

  bool get isSong => this == MediaPlaylistType.song;
  bool get isFavorite => this == MediaPlaylistType.favorite;
  bool get isAlbum => this == MediaPlaylistType.album;
  bool get isPlaylist => this == MediaPlaylistType.playlist;
  bool get isDownload => this == MediaPlaylistType.download;
  bool get isCustomPlaylist => this == MediaPlaylistType.customPlaylist;

  static MediaPlaylistType fromString(String? type) {
    switch (type) {
      case 'favorite':
        return MediaPlaylistType.favorite;
      case 'album':
        return MediaPlaylistType.album;
      case 'playlist':
        return MediaPlaylistType.playlist;
      case 'download':
        return MediaPlaylistType.download;
      case 'song':
        return MediaPlaylistType.song;
      case 'custom_playlist':
        return MediaPlaylistType.customPlaylist;
      default:
        return MediaPlaylistType.playlist;
    }
  }
}

@HiveType(typeId: 15)
class MediaPlaylist<T extends PlayableMedia> extends Equatable
    implements Comparable<MediaPlaylist> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final List<T>? mediaItems;
  @HiveField(4)
  final List<Image> images;
  @HiveField(5)
  final String? url;
  @HiveField(6, defaultValue: '')
  final String? type;

  /// Default constructor for [MediaPlaylist].
  MediaPlaylist({
    required this.id,
    this.title,
    this.description,
    List<T>? mediaItems,
    this.images = const [],
    required this.url,
    this.type = 'playlist',
  }) : mediaItems =
            // TODO: Remove this when the API is fixed
            mediaItems?.where((element) => !element.itemType.isArtist).toList();

  const MediaPlaylist.empty()
      : id = "",
        title = null,
        description = null,
        mediaItems = null,
        images = const [],
        url = null,
        type = null;

  /// Returns a new [MediaPlaylist] with prefilled values for [title] as `Popular Today`.
  factory MediaPlaylist.popularToday(
    List<T> mediaItems, {
    List<Image>? images,
    String? description,
    String? id,
  }) =>
      MediaPlaylist(
        title: "Today's biggest hits",
        mediaItems: mediaItems,
        description: description,
        id: id ?? 'popular_today',
        images: images ?? const [],
        url: null,
      );

  /// Returns a new [MediaPlaylist] with prefilled values for [title] as `Albums`.
  factory MediaPlaylist.albums(
    List<T> mediaItems, {
    List<Image>? images,
    String? description,
    String? id,
  }) =>
      MediaPlaylist(
        title: 'Top Albums',
        mediaItems: mediaItems,
        description: description,
        id: id ?? 'albums',
        images: images ?? const [],
        url: null,
      );

  /// Returns a new [MediaPlaylist] with prefilled values for [title] as `Playlists`.
  factory MediaPlaylist.playlists(
    List<T> mediaItems, {
    List<Image>? images,
    String? description,
    String? id,
  }) =>
      MediaPlaylist(
        title: 'Recommended for today',
        mediaItems: mediaItems,
        description: description,
        id: id ?? 'playlists',
        images: images ?? const [],
        url: null,
      );

  List<MediaItem> get mediaItemsAsMediaItems =>
      (mediaItems ?? []).map((e) => e.toMediaItem()).toList();

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        mediaItems,
        images,
        url,
        type,
      ];

  MediaPlaylist<T> copyWith({
    String? id,
    String? title,
    String? description,
    List<T>? mediaItems,
    List<Image>? images,
    String? url,
    String? type,
  }) {
    return MediaPlaylist<T>(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaItems: mediaItems ?? this.mediaItems,
      images: images ?? this.images,
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }

  MediaPlaylistType get mediaPlaylistType => MediaPlaylistType.fromString(type);

  bool get isFavorite => mediaPlaylistType.isFavorite;
  bool get isAlbum => mediaPlaylistType.isAlbum;
  bool get isPlaylist => mediaPlaylistType.isPlaylist;
  bool get isDownload => mediaPlaylistType.isDownload;
  bool get isSong => mediaPlaylistType.isSong;
  bool get isCustomPlaylist => mediaPlaylistType.isCustomPlaylist;

  bool get isNotEmpty => mediaItems?.isNotEmpty ?? false;

  Map<String, dynamic> toFirestorePayload([bool keepMediaItems = false]) {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images.map((e) => e.toJson()).toList(),
      'mediaItems': (isFavorite && mediaItems != null) || keepMediaItems
          ? mediaItems!.whereType<Song>().map((e) => e.toJson()).toList()
          : [],
      'type': type,
      'url': url,
    };
  }

  factory MediaPlaylist.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    final type = MediaPlaylistType.values.firstWhere(
      (element) => element.type == data['type'],
      orElse: () => MediaPlaylistType.favorite,
    );
    final List<T>? items =
        type.isFavorite || type.isSong || type.isCustomPlaylist
            ? List<T>.from(data['mediaItems'].map((d) => Song.fromJson(d)))
            : null;
    return MediaPlaylist(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      images: List<Image>.from(data['images'].map((e) => Image.fromJson(e))),
      mediaItems: items,
      type: data['type'],
      url: data['url'],
    );
  }

  @override
  int compareTo(MediaPlaylist<PlayableMedia> other) {
    // if id download then it should be first
    if (isDownload) return -1;
    if (other.isDownload) return 1;
    // if id favorite then it should be first
    if (isFavorite) return -1;
    if (other.isFavorite) return 1;
    // else sort by title
    return (title ?? "").compareTo(other.title ?? "");
  }
}
