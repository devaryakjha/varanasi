// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'player_cubit.dart';

class MediaPlayerState extends Equatable {
  final String? currentPlaylist;
  final bool isPlaying;
  final MediaItem? currentMediaItem;
  final QueueState queueState;

  const MediaPlayerState({
    this.currentPlaylist,
    this.isPlaying = false,
    this.currentMediaItem,
    this.queueState = QueueState.empty,
  });

  MediaPlayerState copyWith({
    String? currentPlaylist,
    bool? isPlaying,
    MediaItem? currentMediaItem,
    QueueState? queueState,
  }) {
    return MediaPlayerState(
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      isPlaying: isPlaying ?? this.isPlaying,
      currentMediaItem: currentMediaItem ?? this.currentMediaItem,
      queueState: queueState ?? this.queueState,
    );
  }

  @override
  List<Object?> get props =>
      [currentPlaylist, isPlaying, currentMediaItem, queueState];
}
