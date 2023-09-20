// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'player_cubit.dart';

class MediaPlayerState extends Equatable {
  final String? currentPlaylist;
  final bool isPlaying;

  const MediaPlayerState({this.currentPlaylist, this.isPlaying = false});

  MediaPlayerState copyWith({
    String? currentPlaylist,
    bool? isPlaying,
  }) {
    return MediaPlayerState(
      currentPlaylist: currentPlaylist ?? this.currentPlaylist,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }

  @override
  List<Object?> get props => [currentPlaylist, isPlaying];
}
