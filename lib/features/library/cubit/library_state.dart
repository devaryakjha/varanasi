// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'library_cubit.dart';

class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

class MediaState<T extends PlayableMedia> extends LibraryState {
  final MediaPlaylist<T> playlist;
  final PaletteGenerator colorPalette;
  final ImageProvider image;
  final bool showTitleInAppBar;

  const MediaState(
    this.playlist,
    this.colorPalette,
    this.image, {
    this.showTitleInAppBar = false,
  });

  @override
  List<Object?> get props => [
        playlist,
        colorPalette,
        image,
        showTitleInAppBar,
      ];

  PaletteColor? get baseColor =>
      colorPalette.dominantColor ?? colorPalette.vibrantColor;

  /// - create a list of color which will be used as gradient color
  /// - for the background of the playlist card's thumbnail
  /// - there should be exactly 3 colors in the list
  /// - the first two colors are the muted and vibrant color from the image
  /// - the last color has to be black to blend with the rest of the screen
  List<Color> get gradientColors {
    return [
      baseColor?.color ?? Colors.white,
      appContext.theme.scaffoldBackgroundColor,
    ];
  }

  List<BoxShadow>? get boxShadow => kElevationToShadow[12];

  /// Title of the playlist
  String get title => (playlist.title ?? '').sanitize;

  String get subtitle {
    return (playlist.description ?? '').sanitize;
  }

  PlayableMedia operator [](int index) {
    return playlist.mediaItems![index];
  }

  int get length => playlist.mediaItems!.length;

  bool get needSearchBar => length > 10;

  MediaState<T> copyWith({
    MediaPlaylist<T>? playlist,
    PaletteGenerator? colorPalette,
    ImageProvider? image,
    bool? showTitleInAppBar,
  }) {
    return MediaState<T>(
      playlist ?? this.playlist,
      colorPalette ?? this.colorPalette,
      image ?? this.image,
      showTitleInAppBar: showTitleInAppBar ?? this.showTitleInAppBar,
    );
  }

  List<T> sortedMediaItems(SortBy sortBy) {
    return switch (sortBy) {
      SortBy.title => () {
          List<T> items = playlist.mediaItems ?? [];
          items.sort((a, b) => a.itemTitle.compareTo(b.itemTitle));
          return items;
        },
      _ => () => playlist.mediaItems ?? [],
    }();
  }

  MediaPlaylist<T> sortedMediaPlaylist(SortBy sortBy) {
    return playlist.copyWith(mediaItems: sortedMediaItems(sortBy));
  }

  MediaState<T> toggleAppbarTitle([bool? expanded]) {
    return copyWith(showTitleInAppBar: expanded ?? !showTitleInAppBar);
  }
}

class LibraryError<T> extends LibraryState {
  final T error;
  final StackTrace? stackTrace;

  LibraryError(
    this.error, {
    this.stackTrace,
  }) {
    Logger.instance.e(error.toString(), error: error, stackTrace: stackTrace);
  }

  @override
  List<Object?> get props => [error, stackTrace];
}
