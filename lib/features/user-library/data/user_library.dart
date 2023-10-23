// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  playlist('playlist'),
  @HiveField(3)
  download('download');
  // TODO: Add Artist

  final String type;

  const UserLibraryType(this.type);

  bool get isFavorite => this == UserLibraryType.favorite;
  bool get isAlbum => this == UserLibraryType.album;
  bool get isPlaylist => this == UserLibraryType.playlist;
  bool get isDownload => this == UserLibraryType.download;
}

@HiveType(typeId: 18)
class UserLibrary with EquatableMixin implements Comparable<UserLibrary> {
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

  bool get isFavorite => type.isFavorite || id == "favorite";
  bool get isAlbum => type.isAlbum;
  bool get isPlaylist => type.isPlaylist;
  bool get isDownload => type.isDownload || id == "downloads";

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

  UserLibrary copyWith({
    String? id,
    String? title,
    String? description,
    List<Song>? mediaItems,
    List<Image>? images,
  }) {
    return UserLibrary(
      type: type,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaItems: mediaItems ?? this.mediaItems,
      images: images ?? this.images,
    );
  }

  @override
  int compareTo(UserLibrary other) {
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

  factory Favorite.empty() {
    return const Favorite(mediaItems: []);
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
}
