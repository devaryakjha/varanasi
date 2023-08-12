// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'library_cubit.dart';

abstract class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

class LibraryInitial extends LibraryState {
  const LibraryInitial();

  @override
  List<Object?> get props => [];
}

class LibraryLoading extends LibraryState {
  const LibraryLoading();

  @override
  List<Object?> get props => [];
}

class LibraryLoaded<T extends PlayableMedia> extends LibraryState {
  final SortBy sortBy;
  final MediaPlaylist<T> playlist;
  final PaletteGenerator colorPalette;
  final ImageProvider image;

  const LibraryLoaded(
    this.playlist,
    this.colorPalette,
    this.image, {
    this.sortBy = SortBy.custom,
  });

  @override
  List<Object> get props => [playlist, colorPalette, image, sortBy];

  PaletteColor? get baseColor =>
      colorPalette.vibrantColor ?? colorPalette.dominantColor;

  /// - create a list of color which will be used as gradient color
  /// - for the background of the playlist card's thumbnail
  /// - there should be exactly 3 colors in the list
  /// - the first two colors are the muted and vibrant color from the image
  /// - the last color has to be black to blend with the rest of the screen
  List<Color> get gradientColors {
    return [
      baseColor?.color ?? Colors.white,
      Colors.black12,
    ];
  }

  List<BoxShadow> get boxShadow => [
        const BoxShadow(
          color: Colors.black45,
          offset: Offset(0, 12),
          spreadRadius: 2,
          blurRadius: 36,
        ),
      ];

  /// Title of the playlist
  String get title {
    return (playlist.title ?? '').sanitize;
  }

  String get subtitle {
    return (playlist.description ?? '').sanitize;
  }

  PlayableMedia operator [](int index) {
    return playlist.mediaItems![index];
  }

  int get length => sortedMediaItems.length;

  LibraryLoaded<T> copyWith({
    SortBy? sortBy,
    MediaPlaylist<T>? playlist,
    PaletteGenerator? colorPalette,
    ImageProvider? image,
  }) {
    return LibraryLoaded<T>(
      playlist ?? this.playlist,
      colorPalette ?? this.colorPalette,
      image ?? this.image,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  List<T> get sortedMediaItems {
    return switch (sortBy) {
      SortBy.title => () {
          final items = [...playlist.mediaItems!];
          items.sort((a, b) => a.itemTitle.compareTo(b.itemTitle));
          return items;
        },
      _ => () => playlist.mediaItems!,
    }();
  }
}

class LibraryError<T> extends LibraryState {
  final T error;
  final StackTrace? stackTrace;

  LibraryError(
    this.error, {
    this.stackTrace,
  }) {
    Logger.instance.e(error.toString(), error, stackTrace);
  }

  @override
  List<Object?> get props => [error, stackTrace];
}
