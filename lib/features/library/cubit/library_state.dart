// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'library_cubit.dart';

class LibraryState extends Equatable {
  final Map<String, MediaState> data;

  const LibraryState({
    this.data = const {},
  });

  MediaState? operator [](String key) => data[key];

  @override
  List<Object?> get props => [data];

  LibraryState copyWith({
    Map<String, MediaState>? data,
  }) {
    return LibraryState(
      data: data ?? this.data,
    );
  }

  LibraryState operator +(MediaState other) {
    return copyWith(data: Map.from(data)..addAll({other.id: other}));
  }
}

sealed class MediaState extends Equatable {
  final String id;
  const MediaState(this.id);

  @override
  List<Object?> get props => [id];

  bool get isLoading => this is MediaLoadingState;
  bool get isError => this is MediaErrorState;
  bool get isLoaded => this is MediaLoadedState;
}

class MediaLoadingState extends MediaState {
  const MediaLoadingState(super.id);
}

class MediaErrorState extends MediaState {
  final dynamic error;
  final StackTrace? stackTrace;

  const MediaErrorState(
    super.id,
    this.error, {
    this.stackTrace,
  });

  @override
  List<Object?> get props => [...super.props, error, stackTrace];
}

class MediaLoadedState<T extends PlayableMedia> extends MediaState {
  final MediaPlaylist<T> playlist;
  final PaletteGenerator colorPalette;
  final ImageProvider image;
  final bool showTitleInAppBar;

  const MediaLoadedState(
    super.id,
    this.playlist,
    this.colorPalette,
    this.image, {
    this.showTitleInAppBar = false,
  });

  @override
  List<Object?> get props =>
      [playlist, colorPalette, image, showTitleInAppBar, id];

  PaletteColor? get baseColor =>
      colorPalette.dominantColor ?? colorPalette.vibrantColor;

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

  MediaLoadedState<T> copyWith({
    MediaPlaylist<T>? playlist,
    PaletteGenerator? colorPalette,
    ImageProvider? image,
    bool? showTitleInAppBar,
  }) {
    return MediaLoadedState<T>(
      id,
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

  MediaLoadedState<T> toggleAppbarTitle([bool? expanded]) {
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
