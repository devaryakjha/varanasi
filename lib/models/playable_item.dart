// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

enum PlayableMediaType {
  song,
  album,
  playlist,
}

PlayableMediaType getPlayableMediaType(String type) {
  switch (type) {
    case 'song':
      return PlayableMediaType.song;
    case 'album':
      return PlayableMediaType.album;
    case 'playlist':
      return PlayableMediaType.playlist;
    default:
      return PlayableMediaType.song;
  }
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
  List<Object?> get props => [
        itemId,
        itemTitle,
        itemSubtitle,
        itemUrl,
        itemType,
        artworkUrl,
      ];
}
