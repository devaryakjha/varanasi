import 'package:equatable/equatable.dart';

import 'playable_item.dart';

class MediaPlaylist extends Equatable {
  final String? title;
  final String? description;
  final List<PlayableMedia>? mediaItems;

  const MediaPlaylist({
    this.title,
    this.description,
    this.mediaItems,
  });

  @override
  List<Object?> get props => [title, description, mediaItems];
}
