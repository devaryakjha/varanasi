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
  final MediaPlaylist<T> playlist;
  final PaletteGenerator colorPalette;
  final ImageProvider image;
  final bool showTitleInAppBar;

  const LibraryLoaded(
    this.playlist,
    this.colorPalette,
    this.image, {
    this.showTitleInAppBar = false,
  });

  @override
  List<Object> get props => [playlist, colorPalette, image, showTitleInAppBar];

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
      Colors.black12,
    ];
  }

  List<BoxShadow> get boxShadow => [
        const BoxShadow(
          color: Colors.black45,
          spreadRadius: 8,
          blurRadius: 48,
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

  bool get needSearchBar => length > 10;

  LibraryLoaded<T> copyWith({
    MediaPlaylist<T>? playlist,
    PaletteGenerator? colorPalette,
    ImageProvider? image,
    bool? showTitleInAppBar,
  }) {
    return LibraryLoaded<T>(
      playlist ?? this.playlist,
      colorPalette ?? this.colorPalette,
      image ?? this.image,
      showTitleInAppBar: showTitleInAppBar ?? this.showTitleInAppBar,
    );
  }

  List<T> sortedMediaItems(SortBy sortBy) {
    return switch (sortBy) {
      SortBy.title => () {
          final items = [...playlist.mediaItems!];
          items.sort((a, b) => a.itemTitle.compareTo(b.itemTitle));
          return items;
        },
      _ => () => playlist.mediaItems!,
    }();
  }

  MediaPlaylist<T> sortedMediaPlaylist(SortBy sortBy) {
    return playlist.copyWith(mediaItems: sortedMediaItems(sortBy));
  }

  LibraryLoaded<T> toggleAppbarTitle([bool? expanded]) {
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
    Logger.instance.e(error.toString(), error, stackTrace);
  }

  @override
  List<Object?> get props => [error, stackTrace];
}
