// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'player_cubit.dart';

class MediaPlayerState extends Equatable {
  final String? currentPlaylist;
  final bool isPlaying;
  final MediaItem? currentMediaItem;
  final PaletteGenerator? paletteGenerator;
  final QueueState queueState;

  const MediaPlayerState({
    this.currentPlaylist,
    this.isPlaying = false,
    this.currentMediaItem,
    this.queueState = QueueState.empty,
    this.paletteGenerator,
  });

  MediaPlayerState copyWith({
    String? currentPlaylist,
    bool? isPlaying,
    MediaItem? currentMediaItem,
    PaletteGenerator? paletteGenerator,
    QueueState? queueState,
  }) {
    return MediaPlayerState(
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      isPlaying: isPlaying ?? this.isPlaying,
      currentMediaItem: currentMediaItem ?? this.currentMediaItem,
      paletteGenerator: paletteGenerator ?? this.paletteGenerator,
      queueState: queueState ?? this.queueState,
    );
  }

  @override
  List<Object?> get props => [
        currentPlaylist,
        isPlaying,
        currentMediaItem,
        queueState,
        paletteGenerator
      ];

  Gradient? get gradient {
    if (paletteGenerator == null) return null;
    final palette = paletteGenerator!;
    final PaletteColor? selectedColor = palette.darkVibrantColor ??
        palette.darkMutedColor ??
        palette.dominantColor;
    final Color? color1 = selectedColor?.color.withOpacity(1);
    final Color color2 = appContext.theme.scaffoldBackgroundColor;
    return LinearGradient(
      colors: [
        color1 ?? color2,
        color2,
      ],
      begin: Alignment.topCenter,
      end: FractionalOffset.bottomCenter,
      stops: const [0, 0.8],
    );
  }
}
