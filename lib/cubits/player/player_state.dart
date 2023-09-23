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
}
