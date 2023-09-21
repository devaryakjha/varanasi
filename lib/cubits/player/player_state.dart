// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'player_cubit.dart';

class MediaPlayerState extends Equatable {
  final String? currentPlaylist;
  final bool isPlaying;
  final MediaItem? currentMediaItem;

  const MediaPlayerState(
      {this.currentPlaylist, this.isPlaying = false, this.currentMediaItem});

  MediaPlayerState copyWith({
    String? currentPlaylist,
    bool? isPlaying,
    MediaItem? currentMediaItem,
  }) {
    return MediaPlayerState(
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      isPlaying: isPlaying ?? this.isPlaying,
      currentMediaItem: currentMediaItem ?? this.currentMediaItem,
    );
  }

  @override
  List<Object?> get props => [currentPlaylist, isPlaying, currentMediaItem];
}
