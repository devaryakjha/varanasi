import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/cubits/download/download_cubit.dart';
import 'package:varanasi_mobile_app/models/app_config.dart';
import 'package:varanasi_mobile_app/models/download.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';

import 'typings.dart';

final class AudioHandlerImpl extends BaseAudioHandler
    implements AudioPlayerHandler {
  late final AudioPlayer _player;

  final ConfigCubit configCubit;

  final _playlist = ConcatenatingAudioSource(children: []);

  final _mediaItemExpando = Expando<MediaItem>();

  @override
  BehaviorSubject<double> get speed => BehaviorSubject.seeded(1.0);

  @override
  BehaviorSubject<double> get volume => BehaviorSubject.seeded(1.0);

  AudioPlayer get player => _player;

  bool _isSongDownloaded(String itemId) {
    final box = Hive.box<DownloadedMedia>(AppStrings.downloadBoxName);
    return box.containsKey(itemId);
  }

  /// A stream of the current effective sequence from just_audio.
  Stream<List<IndexedAudioSource>> get _effectiveSequence {
    return Rx.combineLatest3(
      _player.sequenceStream,
      _player.shuffleIndicesStream,
      _player.shuffleModeEnabledStream,
      (sequence, shuffleIndices, shuffleModeEnabled) {
        if (sequence == null) return [];
        if (!shuffleModeEnabled) return sequence;
        if (shuffleIndices == null) return null;
        if (shuffleIndices.length != sequence.length) return null;
        return shuffleIndices.map((i) => sequence[i]).toList();
      },
    ).whereType<List<IndexedAudioSource>>();
  }

  int? getQueueIndex(
    int? currentIndex,
    bool shuffleModeEnabled,
    List<int>? shuffleIndices,
  ) {
    final effectiveIndices = _player.effectiveIndices ?? [];
    final shuffleIndicesInv = List.filled(effectiveIndices.length, 0);
    for (var i = 0; i < effectiveIndices.length; i++) {
      shuffleIndicesInv[effectiveIndices[i]] = i;
    }
    return (shuffleModeEnabled &&
            ((currentIndex ?? 0) < shuffleIndicesInv.length))
        ? shuffleIndicesInv[currentIndex ?? 0]
        : currentIndex;
  }

  @override
  Stream<QueueState> get queueState {
    return Rx.combineLatest3(
      queue,
      playbackState,
      _player.shuffleIndicesStream.whereType<List<int>>(),
      (queue, playbackState, shuffleIndices) {
        return QueueState(
          queue,
          playbackState.queueIndex,
          playbackState.shuffleMode == AudioServiceShuffleMode.all
              ? shuffleIndices
              : null,
          playbackState.repeatMode,
        );
      },
    ).where((state) {
      return state.shuffleIndices == null ||
          state.queue.length == state.shuffleIndices!.length;
    });
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode == AudioServiceShuffleMode.all;
    if (enabled) {
      await _player.shuffle();
    }
    playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    await _player.setShuffleModeEnabled(enabled);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _player.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed.add(speed);
    await _player.setSpeed(speed);
  }

  @override
  Future<void> setVolume(double volume) async {
    this.volume.add(volume);
    await _player.setVolume(volume);
  }

  AudioHandlerImpl(this.configCubit, [AudioPlayer? player]) {
    _player = player ?? AudioPlayer();
    _init();
  }

  void _init() async {
    /// setup audio session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    // Broadcast speed changes. Debounce so that we don't flood the notification
    // with updates.
    speed.debounceTime(const Duration(milliseconds: 250)).listen((speed) {
      playbackState.add(playbackState.value.copyWith(speed: speed));
    });
    // Load config from shared preferences.
    final box = AppConfig.getBox;
    final value = box.values.first;
    final repeatMode = value.repeatMode;
    await setRepeatMode(AudioServiceRepeatMode.values[repeatMode]);
    // Load and broadcast the initial queue
    final savedPlaylist = configCubit.savedPlaylist;
    final initialIndex = configCubit.savedPlaylistIndex ?? 0;
    final initialPosition = configCubit.savedPosition ?? Duration.zero;
    if (savedPlaylist != null) {
      await updateQueue(savedPlaylist.mediaItemsAsMediaItems);
    }
    // Broadcast media item changes.
    Rx.combineLatest4(
      _player.currentIndexStream,
      queue,
      _player.shuffleModeEnabledStream,
      _player.shuffleIndicesStream,
      (index, queue, shuffleModeEnabled, shuffleIndices) {
        final queueIndex =
            getQueueIndex(index, shuffleModeEnabled, shuffleIndices);
        return (queueIndex != null && queueIndex < queue.length)
            ? queue[queueIndex]
            : null;
      },
    ).whereType<MediaItem>().distinct().listen(mediaItem.add);
    // Propagate all events from the audio player to AudioService clients.
    _player.playbackEventStream.listen(_broadcastState);
    _player.shuffleModeEnabledStream
        .listen((enabled) => _broadcastState(_player.playbackEvent));
    // In this example, the service stops when reaching the end.
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        stop();
        _player.seek(Duration.zero, index: 0);
      }
    });
    // Broadcast the current queue.
    _effectiveSequence.map((sequence) {
      return sequence.map((source) => _mediaItemExpando[source]!).toList();
    }).pipe(queue);
    // Load the playlist.
    _playlist.addAll(queue.value.map(_itemToSource).toList());
    await _player.setAudioSource(_playlist,
        initialIndex: initialIndex, initialPosition: initialPosition);
  }

  AudioSource _itemToSource(MediaItem mediaItem) {
    final itemId = mediaItem.extras?['itemId'] as String? ?? mediaItem.id;
    final downloaded = _isSongDownloaded(itemId);
    if (!downloaded) {
      final uri = Uri.parse(mediaItem.id);
      final cacheFile =
          appContext.read<DownloadCubit>().getCacheFile(itemId, mediaItem.id);
      final audioSource = LockCachingAudioSource(uri, cacheFile: cacheFile);
      _mediaItemExpando[audioSource] = mediaItem;
      return audioSource;
    }
    final path = appContext.read<DownloadCubit>().getDownloadPath(itemId);
    final audioSource = AudioSource.file(path);
    _mediaItemExpando[audioSource] = mediaItem;
    return audioSource;
  }

  List<AudioSource> _itemsToSources(List<MediaItem> mediaItems) =>
      mediaItems.map(_itemToSource).toList();

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final source = _itemToSource(mediaItem);
    await _playlist.add(source);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await _playlist.addAll(_itemsToSources(mediaItems));
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    final source = _itemToSource(mediaItem);
    await _playlist.insert(index, source);
  }

  @override
  Future<void> updateQueue(List<MediaItem> queue) async {
    await _playlist.clear();
    await _playlist.addAll(_itemsToSources(queue));
  }

  @override
  Future<void> updateMediaItem(MediaItem mediaItem) async {
    final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
    _mediaItemExpando[_player.sequence![index]] = mediaItem;
  }

  @override
  Future<void> removeQueueItem(MediaItem mediaItem) async {
    final index = queue.value.indexOf(mediaItem);
    await _playlist.removeAt(index);
  }

  @override
  Future<void> moveQueueItem(int currentIndex, int newIndex) async {
    await _playlist.move(currentIndex, newIndex);
  }

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _playlist.children.length) return;
    // This jumps to the beginning of the queue item at [index].
    _player.seek(Duration.zero,
        index: _player.shuffleModeEnabled
            ? _player.shuffleIndices![index]
            : index);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere(
        (state) => state.processingState == AudioProcessingState.idle);
    configCubit.clearCurrentPlaylist();
    configCubit.clearCurrentPlaylistIndex();
    configCubit.clearCurrentPosition();
  }

  /// Broadcasts the current state to all clients.
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    final queueIndex = getQueueIndex(
        event.currentIndex, _player.shuffleModeEnabled, _player.shuffleIndices);
    playbackState.add(playbackState.value.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: queueIndex,
    ));
  }
}
