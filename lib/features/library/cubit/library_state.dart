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

  /// TODO: change the assignment to constructor creation time
  List<Color> get gradientColors {
    /// create a list of color which will be used as gradient color
    /// for the background of the playlist card's thumbnail
    /// there should be exactly 3 colors in the list
    /// the first two colors are the muted and vibrant color from the image
    /// the last color has to be black to blend with the rest of the screen
    return [
      colorPalette.darkMutedColor?.color ?? Colors.white,
      Colors.black,
    ];
  }

  List<BoxShadow> get boxShadow => [
        BoxShadow(
          color: colorPalette.mutedColor?.titleTextColor ?? Colors.black26,
          offset: const Offset(0, 0),
        ),
      ];

  /// Title of the playlist
  String get title {
    return (playlist.title ?? '').sanitize;
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
