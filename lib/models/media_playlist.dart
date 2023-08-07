import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

class MediaPlaylist<T extends PlayableMedia> extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final List<T>? mediaItems;
  final List<Image> images;

  const MediaPlaylist({
    this.id,
    this.title,
    this.description,
    this.mediaItems,
    this.images = const [],
  });

  @override
  List<Object?> get props => [title, description, mediaItems, images];
}
