import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';

part 'user_library.g.dart';

@HiveType(typeId: 22)
enum UserLibraryType {
  @HiveField(0)
  favorite('favorite'),
  @HiveField(1)
  album('album'),
  @HiveField(2)
  playlist('playlist');
  // TODO: Add Artist

  final String type;

  const UserLibraryType(this.type);

  bool get isFavorite => this == UserLibraryType.favorite;
  bool get isAlbum => this == UserLibraryType.album;
  bool get isPlaylist => this == UserLibraryType.playlist;
}

@HiveType(typeId: 18)
class UserLibrary extends Equatable {
  @HiveField(0)
  final UserLibraryType type;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? description;
  @HiveField(4, defaultValue: [])
  final List<Song> mediaItems;
  @HiveField(5, defaultValue: [])
  final List<Image> images;

  const UserLibrary({
    required this.id,
    this.title,
    this.description,
    this.mediaItems = const [],
    this.images = const [],
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, description, mediaItems, images];

  bool get isEmpty => mediaItems.isEmpty;

  bool get isNotEmpty => mediaItems.isNotEmpty;

  bool get isFavorite => type.isFavorite;
  bool get isAlbum => type.isAlbum;
  bool get isPlaylist => type.isPlaylist;

  const UserLibrary.empty(this.type)
      : id = "",
        title = null,
        description = null,
        mediaItems = const [],
        images = const [];

  @override
  bool? get stringify => true;

  MediaPlaylist<Song> toMediaPlaylist() {
    return MediaPlaylist(
      id: id,
      title: title,
      description: description,
      images: images,
      mediaItems: mediaItems,
    );
  }
}

@HiveType(typeId: 19)
final class Favorite extends UserLibrary {
  const Favorite({
    required super.mediaItems,
  }) : super(
          type: UserLibraryType.favorite,
          images: const [Image.likedSongs],
          id: "favorite",
          title: "Liked Songs",
          description: "Songs you liked",
        );

  static const String boxKey = "favorite";

  const Favorite.empty() : super.empty(UserLibraryType.favorite);

  Favorite copyWith({
    List<Song>? mediaItems,
  }) {
    return Favorite(
      mediaItems: mediaItems ?? this.mediaItems,
    );
  }
}

@HiveType(typeId: 20)
final class AlbumLibrary extends UserLibrary {
  const AlbumLibrary({
    required super.id,
    super.title,
    super.description,
    required super.mediaItems,
    required super.images,
  }) : super(type: UserLibraryType.album);

  const AlbumLibrary.empty() : super.empty(UserLibraryType.album);
}

@HiveType(typeId: 21)
final class PlaylistLibrary extends UserLibrary {
  const PlaylistLibrary({
    required super.id,
    super.title,
    super.description,
    required super.mediaItems,
    required super.images,
  }) : super(type: UserLibraryType.playlist);

  const PlaylistLibrary.empty() : super.empty(UserLibraryType.playlist);
}