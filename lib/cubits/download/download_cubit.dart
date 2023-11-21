import 'dart:async';
import 'dart:io';

import 'package:background_downloader/background_downloader.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/models/download_url.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/dialogs/app_dialog.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

part 'download_state.dart';

class DownloadCubit extends AppCubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  late final Box<DownloadedMedia> _downloadBox;
  late final FileDownloader _downloader;

  late final Map<String, Song> _songMap;

  Logger get _logger => Logger.instance;

  Box<DownloadedMedia> get downloadBox => _downloadBox;

  FileDownloader get downloader => _downloader;

  DownloadLoadedState get loadedState => state as DownloadLoadedState;

  @override
  FutureOr<void> init() async {
    final baseDir = await getApplicationDocumentsDirectory();
    emit(DownloadLoadedState(downloadDirectory: baseDir));
    _songMap = {};
    _downloadBox = Hive.box<DownloadedMedia>(AppStrings.downloadBoxName);
    _downloader = FileDownloader()
      ..trackTasks()
      ..resumeFromBackground();
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
          media: _songMap[update.task.taskId]!,
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
      } else if (update.status == TaskStatus.canceled) {
        _downloadBox.delete(item.id);
        _logger.i('Download canceled for ${item.id}');
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
    final dquality = AppConfig.effectiveDlQuality!;
    final dlink = song.downloadUrl?.firstWhere(
      (e) => e.quality == dquality.quality,
    );
    return DownloadTask(
      taskId: song.itemId,
      url: dlink?.link ?? song.itemUrl,
      filename: fileName,
      updates: Updates.statusAndProgress,
    );
  }

  Future<void> downloadSong(PlayableMedia song) async {
    assert(song is Song, 'Only songs can be downloaded');
    if (song is! Song) return;
    final quality = await getDownloadQuality();
    if (quality == null) return;
    _songMap[song.itemId] = song;
    final queued = await _downloader.enqueue(_songToTask(song));
    _logger.i('Queued ${song.itemId} status: $queued');
  }

  Future<void> batchDownload(MediaPlaylist playlist) async {
    final quality = await getDownloadQuality();
    if (quality == null) return;
    final songs = playlist.mediaItems ?? [];
    final filteredsong = songs.whereType<Song>().where(_isNotDownloaded);
    final tasks = filteredsong.map(_songToTask).toList();
    for (final song in filteredsong) {
      _songMap[song.itemId] = song;
    }
    emit(loadedState.updateProgress(MapEntry(playlist.id, 0)));
    await _downloader.downloadBatch(
      tasks,
      batchProgressCallback: (succeeded, failed) {
        final percentComplete = (succeeded + failed) / tasks.length;
        emit(
            loadedState.updateProgress(MapEntry(playlist.id, percentComplete)));
        _logger.i('Batch progress: $succeeded, $failed');
      },
      taskStatusCallback: _handleTaskStatusUpdate,
      taskProgressCallback: _handleTaskProgressUpdate,
    );
  }

  Future<void> cancelDownload(PlayableMedia media) =>
      _downloader.cancelTaskWithId(media.itemId);

  Future<void> batchCancel(MediaPlaylist media) async {
    await _downloader.cancelTasksWithIds(
      media.mediaItems?.map((e) => e.itemId).toList() ?? [],
    );
    await _batchDelete(media);
  }

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

  Stream<({bool downloading, bool downloaded})> listenToPlaylist(
    MediaPlaylist playlist,
  ) {
    final items = playlist.mediaItems ?? [];
    return Rx.combineLatestList(items.map(listen)).map(
      (items) {
        final downloading = items.any((e) => e?.downloading ?? false);
        final downloaded = items.every((e) => e?.downloadComplete ?? false);
        return (downloaded: downloaded, downloading: downloading);
      },
    );
  }

  DownloadedMedia? getDownloadedMedia(PlayableMedia song) =>
      _downloadBox.get(song.itemId);

  Future<void> deleteSingle(PlayableMedia media) {
    return AppDialog.showAlertDialog(
      title: "Remove from Downloads?",
      message: "You won't be able to listen to this song offline.",
      onConfirm: () async => _deleteSingle(media),
      confirmLabel: "Remove",
    );
  }

  Future<void> _deleteSingle(PlayableMedia media) {
    final item = _downloadBox.get(media.itemId);
    if (item?.path.isNotEmpty ?? false) {
      _deleteFile(item!.path);
    }
    return _downloadBox.delete(media.itemId);
  }

  Future<void> batchDelete(MediaPlaylist song) async {
    await AppDialog.showAlertDialog(
      title: "Remove from Downloads?",
      message: "You won't be able to listen to these songs offline.",
      onConfirm: () => _batchDelete(song),
      confirmLabel: "Remove",
    );
  }

  Future<void> _batchDelete(MediaPlaylist song) async {
    final keys = song.mediaItems?.map((e) => e.itemId) ?? [];
    final values = keys
        .map((e) => _downloadBox.get(e))
        .whereType<DownloadedMedia>()
        .toList();
    // delete files from disk
    for (final value in values) {
      if (value.path.isNotEmpty) {
        _deleteFile(value.path);
      }
    }
    return _downloadBox.deleteAll(song.mediaItems?.map((e) => e.itemId) ?? []);
  }

  Future<void> _deleteFile(String path) async {
    try {
      final file = File(path);
      final exists = file.existsSync();
      if (!exists) {
        _logger.i('File does not exist: $path');
        return Future.value(null);
      }
      await file.delete(recursive: true);
      _logger.i('Deleted file: $path');
    } catch (e) {
      _logger.e('Error deleting file: $e');
      return Future.value(null);
    }
  }

  Future deleteAll() async {
    final keys = _downloadBox.keys.toList();
    for (final key in keys) {
      final item = _downloadBox.get(key);
      if (item?.path.isNotEmpty ?? false) {
        await _deleteFile(item!.path);
      }
    }
    await _downloadBox.clear();
  }

  bool _isDownloaded(PlayableMedia song) =>
      _downloadBox.containsKey(song.itemId);

  bool _isNotDownloaded(PlayableMedia song) => !_isDownloaded(song);

  Future<DownloadQuality?> getDownloadQuality() async {
    final savedQuality = AppConfig.effectiveDlQuality;
    if (savedQuality != null) return savedQuality;
    AppConfig.effectiveDlQuality = await AppDialog.showOptionsPicker(
      null,
      savedQuality ?? DownloadQuality.high,
      DownloadQuality.values,
      (q) => q.describeQuality,
      title: "Select Download Quality",
    );
    return AppConfig.effectiveDlQuality;
  }

  Stream<MediaPlaylist> get downloadLibraryStream {
    return _downloadBox.watch().map((event) => toUserLibrary());
  }

  MediaPlaylist toUserLibrary() {
    final List<DownloadedMedia> values = _downloadBox.values.toList();
    final library = MediaPlaylist(
      id: "downloads",
      title: "Downloads",
      description: "Your downloaded songs",
      mediaItems: values.map((e) => e.media).toList(),
      images: const [Image.likedSongs],
      type: 'download',
      url: null,
    );
    return library;
  }

  String getDownloadPath(String id) {
    final item = _downloadBox.get(id);
    final filename = _fileNameFromSong(item!.media);
    return path.join(loadedState.downloadDirectory.path, '', filename);
  }

  File? getCacheFile(String itemId, String itemUrl) {
    final ext = itemUrl.split('.').last;
    final fileName = '$itemId.$ext';
    return File(
        path.join(loadedState.downloadDirectory.path, 'cache', fileName));
  }
}
