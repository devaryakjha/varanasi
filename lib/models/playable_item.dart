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
  final String itemId;
  final String itemTitle;
  final String itemSubtitle;
  final String itemUrl;

  PlayableMediaType get itemType;

  const PlayableMedia({
    required this.itemId,
    required this.itemTitle,
    required this.itemSubtitle,
    required this.itemUrl,
  });

  String? get artworkUrl;

  @override
  List<Object?> get props =>
      [itemId, itemTitle, itemSubtitle, itemUrl, itemType];
}
