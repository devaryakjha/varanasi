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

class LibraryLoaded extends LibraryState {
  final MediaPlaylist playlist;
  final PaletteGenerator colorPalette;
  final ImageProvider image;
  const LibraryLoaded(this.playlist, this.colorPalette, this.image);

  @override
  List<Object> get props => [playlist, colorPalette, image];

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

  int get length => playlist.mediaItems!.length;
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
