// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'download_cubit.dart';

sealed class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

class DownloadInitial extends DownloadState {}

class DownloadLoadedState extends DownloadState {
  final Map<String, double> playlistProgressMap;
  final Directory downloadDirectory;

  const DownloadLoadedState({
    this.playlistProgressMap = const {},
    required this.downloadDirectory,
  });

  @override
  List<Object> get props => [playlistProgressMap, downloadDirectory];

  DownloadLoadedState copyWith({
    Map<String, double>? playlistProgressMap,
    Directory? downloadDirectory,
  }) {
    return DownloadLoadedState(
      playlistProgressMap: playlistProgressMap ?? this.playlistProgressMap,
      downloadDirectory: downloadDirectory ?? this.downloadDirectory,
    );
  }

  DownloadLoadedState updateProgress(MapEntry<String, double> entry) {
    final Map<String, double> oldProgress = Map.from(playlistProgressMap)
      ..addEntries([entry]);
    return copyWith(
      playlistProgressMap: oldProgress,
    );
  }
}
