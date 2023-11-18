// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/playable_item_impl.dart';
import 'package:varanasi_mobile_app/models/song.dart';

part 'user_library.g.dart';

enum UserLibraryType {
  favorite('favorite'),
  album('album'),
  playlist('playlist'),
  download('download');
  // TODO: Add Artist

  final String type;

  const UserLibraryType(this.type);

  bool get isFavorite => this == UserLibraryType.favorite;
  bool get isAlbum => this == UserLibraryType.album;
  bool get isPlaylist => this == UserLibraryType.playlist;
  bool get isDownload => this == UserLibraryType.download;
}

class UserLibrary with EquatableMixin implements Comparable<UserLibrary> {
  final DocumentReference<Map<String, dynamic>>? reference;
  final UserLibraryType type;
  final String id;
  final String? title;
  final String? description;
  final List<PlayableMedia> mediaItems;
  final List<Image> images;

  const UserLibrary({
    required this.id,
    this.title,
    this.description,
    this.mediaItems = const [],
    this.images = const [],
    required this.type,
    this.reference,
  });

  @override
  List<Object?> get props =>
      [id, title, description, mediaItems, images, reference];

  bool get isEmpty => mediaItems.isEmpty;

  bool get isNotEmpty => mediaItems.isNotEmpty;

  bool get isFavorite => type.isFavorite || id == "favorite";
  bool get isAlbum => type.isAlbum;
  bool get isPlaylist => type.isPlaylist;
  bool get isDownload => type.isDownload || id == "downloads";

  const UserLibrary.empty(this.type)
      : reference = null,
        id = "",
        title = null,
        description = null,
        mediaItems = const [],
        images = const [];

  @override
  bool? get stringify => true;

  MediaPlaylist toMediaPlaylist() {
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
    List<PlayableMedia>? mediaItems,
    List<Image>? images,
    DocumentReference<Map<String, dynamic>>? reference,
  }) {
    return UserLibrary(
      type: type,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      mediaItems: mediaItems ?? this.mediaItems,
      images: images ?? this.images,
      reference: reference ?? this.reference,
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

  Map<String, dynamic> toFirestorePayload() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images.map((e) => e.toJson()).toList(),
      'mediaItems': isFavorite
          ? mediaItems
              .map((e) => e.toPlayableMediaImpl().toFirestorePayload())
              .toList()
          : [],
      'type': type.type,
    };
  }

  factory UserLibrary.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    final type = UserLibraryType.values.firstWhere(
      (element) => element.type == data['type'],
      orElse: () => UserLibraryType.favorite,
    );
    return UserLibrary(
      reference: snapshot.reference,
      id: data['id'],
      title: data['title'],
      description: data['description'],
      images: List<Image>.from(
        data['images'].map((e) => Image.fromJson(e)),
      ),
      mediaItems: List<PlayableMedia>.from(
        data['mediaItems'].map(
          (e) => PlayableMediaImpl.fromFirestorePayload(e),
        ),
      ),
      type: type,
    );
  }
}
