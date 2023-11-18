// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';

part 'media_playlist.g.dart';

@HiveType(typeId: 15)
class MediaPlaylist<T extends PlayableMedia> extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final List<T>? mediaItems;
  @HiveField(4)
  final List<Image> images;

  /// Default constructor for [MediaPlaylist].
  MediaPlaylist({
    this.id,
    this.title,
    this.description,
    List<T>? mediaItems,
    this.images = const [],
  }) : mediaItems =
            // TODO: Remove this when the API is fixed
            mediaItems?.where((element) => !element.itemType.isArtist).toList();

  const MediaPlaylist.empty()
      : id = null,
        title = null,
        description = null,
        mediaItems = null,
        images = const [];

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
        id: id,
        images: images ?? const [],
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
        id: id,
        images: images ?? const [],
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
        id: id,
        images: images ?? const [],
      );

  List<MediaItem> get mediaItemsAsMediaItems =>
      (mediaItems ?? []).map((e) => e.toMediaItem()).toList();

  @override
  List<Object?> get props => [id, title, description, mediaItems, images];

  MediaPlaylist<T> copyWith({
    String? id,
    String? title,
    String? description,
    List<T>? mediaItems,
    List<Image>? images,
  }) {
    return MediaPlaylist<T>(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaItems: mediaItems ?? this.mediaItems,
      images: images ?? this.images,
    );
  }

  UserLibrary toUserLibrary() {
    return UserLibrary(
      id: id!,
      title: title,
      description: description,
      mediaItems: mediaItems?.whereType<Song>().toList() ?? [],
      images: images,
      type: UserLibraryType.playlist,
    );
  }
}
