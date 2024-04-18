import 'package:equatable/equatable.dart';
import 'package:varanasi/app/shared/domain/entities/image.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';
import 'package:varanasi/core/dimesions.dart';

class Media extends Equatable {
  const Media({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.images,
    required this.token,
  });

  final String id;
  final String title;
  final String subTitle;
  final String token;
  final MediaType type;
  final List<Image> images;

  double get height {
    return switch (type) {
      MediaType.artist => kArtistCardHeight,
      MediaType.playlist => kPlaylistCardHeight,
      MediaType.album => kAlbumCardHeight,
    };
  }

  double get width {
    return switch (type) {
      MediaType.artist => kArtistCardWidth,
      MediaType.playlist => kPlaylistCardWidth,
      MediaType.album => kAlbumCardWidth,
    };
  }

  String get highestQualityImage {
    return images.last.link;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subTitle,
        type,
        images,
        token,
      ];
}
