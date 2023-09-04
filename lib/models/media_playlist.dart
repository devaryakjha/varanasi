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

  @override
  List<Object?> get props => [id, title, description, mediaItems, images];
}
