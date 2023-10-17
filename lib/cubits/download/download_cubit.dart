import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'download_state.dart';

class DownloadCubit extends AppCubit<DownloadState> {
  DownloadCubit() : super(const DownloadState());

  late final Box<DownloadedMedia> _downloadBox;
  late final FileDownloader _downloader;

  late final Map<String, Song> _expando;

  Logger get _logger => Logger.instance;

  @override
  FutureOr<void> init() async {
    _expando = {};
    _downloadBox =
        await Hive.openBox<DownloadedMedia>(AppStrings.downloadBoxName);
    _downloader = FileDownloader();
    _downloader.updates.listen((update) {
      if (update is TaskStatusUpdate) {
        _handleTaskStatusUpdate(update);
      } else if (update is TaskProgressUpdate) {
        _handleTaskProgressUpdate(update);
      }
    });
  }

  void _handleTaskProgressUpdate(TaskProgressUpdate update) {
    final item = _downloadBox.get(update.task.taskId);
    if (item != null) {
      _downloadBox.put(
        update.task.taskId,
        item.copyWith(progress: update.progress),
      );
      _logger.i('Dl pro for ${item.id}: ${item.progress}');
    }
  }

  void _handleTaskStatusUpdate(TaskStatusUpdate update) async {
    if (update.status == TaskStatus.enqueued) {
      _logger.i('Download enqueued for ${update.task.taskId}');
      _downloadBox.put(
        update.task.taskId,
        DownloadedMedia(
          id: update.task.taskId,
          progress: 0,
          downloadComplete: false,
          media: _expando[update.task.taskId]!,
          path: '',
        ),
      );
      return;
    }
    final item = _downloadBox.get(update.task.taskId);
    if (update.status.isNotFinalState && item != null) {
      _downloadBox.put(
        item.id,
        item.copyWith(downloading: update.status == TaskStatus.running),
      );
      _logger.i('Download status for ${update.task.taskId}: '
          '${update.status}');
      return;
    }

    if (item != null) {
      if (update.status == TaskStatus.complete) {
        final path = await update.task.filePath();
        _downloadBox.put(
          item.id,
          item.copyWith(
            downloadComplete: true,
            progress: 1,
            path: path,
            downloading: false,
          ),
        );
        _logger.i('Download complete for ${item.id} path: $path');
      } else if (update.status.isFinalState) {
        _downloadBox.delete(item.id);
        _logger.i('Download failed for ${item.id}');
      }
    }
  }

  String _fileNameFromSong(Song song) {
    final ext = song.itemUrl.split('.').last;
    return '${song.itemId}.$ext';
  }

  DownloadTask _songToTask(Song song) {
    final fileName = _fileNameFromSong(song);
    return DownloadTask(
      taskId: song.itemId,
      url: song.itemUrl,
      filename: fileName,
      updates: Updates.statusAndProgress,
    );
  }

  Future<void> downloadSong(PlayableMedia song) async {
    assert(song is Song, 'Only songs can be downloaded');
    if (song is! Song) return;
    _expando[song.itemId] = song;
    final queued = await _downloader.enqueue(_songToTask(song));
    _logger.i('Queued ${song.itemId} status: $queued');
  }

  Future<void> batchDownload(MediaPlaylist playlist) async {
    final songs = playlist.mediaItems ?? [];
    final filteredsong = songs.whereType<Song>();
    final tasks = filteredsong.map(_songToTask).toList();
    for (final song in filteredsong) {
      _expando[song.itemId] = song;
    }
    await _downloader.downloadBatch(
      tasks,
      taskStatusCallback: _handleTaskStatusUpdate,
      taskProgressCallback: _handleTaskProgressUpdate,
    );
  }

  Future<void> cancelDownload(PlayableMedia media) =>
      _downloader.cancelTaskWithId(media.itemId);

  /// Returns a stream of [DownloadedMedia] for the given [song].
  ///
  /// The stream will emit the current download status of the song and
  ///
  /// will continue to emit updates until the download is complete or
  Stream<DownloadedMedia?> listen(PlayableMedia song) {
    final curr = _downloadBox.get(song.itemId);
    return Rx.concat([
      if (curr != null) Stream.value(curr),
      _downloadBox.watch(key: song.itemId).map((e) => e.value)
    ]);
  }

  DownloadedMedia? getDownloadedMedia(PlayableMedia song) =>
      _downloadBox.get(song.itemId);

  Future<void> deleteDownloadedMedia(PlayableMedia song) =>
      _downloadBox.delete(song.itemId);
}
