// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

class MediaPlaylist<T extends PlayableMedia> extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final List<T>? mediaItems;
  final List<Image> images;

  /// Default constructor for [MediaPlaylist].
  const MediaPlaylist({
    this.id,
    this.title,
    this.description,
    this.mediaItems,
    this.images = const [],
  });

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
        title: 'Popular Today',
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
        title: 'Albums',
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
        title: 'Playlists',
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
}
