// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'download_cubit.dart';

class DownloadState extends Equatable {
  final Map<String, double> playlistProgressMap;

  const DownloadState({
    this.playlistProgressMap = const {},
  });

  @override
  List<Object> get props => [playlistProgressMap];

  DownloadState copyWith({
    Map<String, double>? playlistProgressMap,
  }) {
    return DownloadState(
      playlistProgressMap: playlistProgressMap ?? this.playlistProgressMap,
    );
  }

  DownloadState updateProgress(MapEntry<String, double> entry) {
    final Map<String, double> oldProgress = Map.from(playlistProgressMap)
      ..addEntries([entry]);
    return copyWith(
      playlistProgressMap: oldProgress,
    );
  }
}
