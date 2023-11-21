import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/cubits/config/config_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/mixins/cachable_mixin.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/player/audio_handler_impl.dart';
import 'package:varanasi_mobile_app/utils/player/typings.dart';
import 'package:varanasi_mobile_app/utils/safe_animate_to_pageview.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';
import 'package:varanasi_mobile_app/utils/services/recent_media_service.dart';

part 'player_state.dart';

extension MediaPlayerCubitExtension on BuildContext {
  MediaPlayerCubit get readMediaPlayerCubit => read<MediaPlayerCubit>();
  MediaPlayerCubit get selectMediaPlayerCubit => watch<MediaPlayerCubit>();
}

class MediaColorPalette {
  final Color? backgroundColor;
  final Color? foregroundColor;

  const MediaColorPalette({
    this.backgroundColor,
    this.foregroundColor,
  });

  factory MediaColorPalette.fromPaletteGenerator(PaletteGenerator palette) {
    final PaletteColor? selectedColor = palette.darkVibrantColor ??
        palette.darkMutedColor ??
        palette.dominantColor;
    final Color? backgroundColor = selectedColor?.color.withOpacity(1);
    final Color? foregroundColor = selectedColor?.bodyTextColor.withOpacity(1);
    return MediaColorPalette(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
    );
  }
}

class MediaPlayerCubit extends AppCubit<MediaPlayerState>
    with DataProviderProtocol, CacheableService {
  late final AudioHandlerImpl audioHandler;
  late final Box _box;

  MediaPlayerCubit() : super(const MediaPlayerState());

  ConfigCubit get _configCubit => ConfigCubit.read();

  Future<void> playFromMediaPlaylist<T extends PlayableMedia>(
    MediaPlaylist<T> playlist, {
    PlayableMedia? initialMedia,
    bool autoPlay = true,
  }) async {
    RecentMediaService.addToRecentlyPlayed(playlist);
    if (playlist.id == state.currentPlaylist && !audioHandler.player.playing) {
      final startIndex = initialMedia == null
          ? null
          : state.queueState.queue.indexOf(initialMedia.toMediaItem());
      if (startIndex != null) {
        await skipToIndex(startIndex, autoPlay);
      } else if (autoPlay) {
        await play();
      }
      return;
    }
    unawaited(_configCubit.saveCurrentPlaylist(playlist));
    emit(state.copyWith(currentPlaylist: playlist.id));
    await audioHandler.updateQueue(playlist.mediaItemsAsMediaItems);
    final shuffleModeEnabled = audioHandler.player.shuffleModeEnabled;
    if (shuffleModeEnabled) {
      await audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    }
    final startIndex = initialMedia == null
        ? null
        : state.queueState.queue.indexOf(initialMedia.toMediaItem());
    if (startIndex != null) {
      await skipToIndex(startIndex, autoPlay);
    } else if (autoPlay) {
      await play();
    }
  }

  Future<void> playFromSong(PlayableMedia media) async {
    assert(media.itemType == PlayableMediaType.song, 'Media must be a song');
    final song = (await fetchSong(media))!;
    cache(media.cacheKey, song);
    await playFromMediaPlaylist(song.toMediaPlaylist());
  }

  Future<Song?> fetchSong(PlayableMedia media) async {
    final cached = maybeGetCached<Song>(media.cacheKey);
    return cached ?? await fetchSongFromNetwork(media);
  }

  Future<Song?> fetchSongFromNetwork(media) async {
    return (await fetchUri(
      media.moreInfoUrl,
      options: CommonOptions(
        transformer: (response) {
          if (response is! List<dynamic>) {
            throw Exception('Invalid response');
          }
          final data = response;
          if (data.isEmpty) {
            throw Exception('No data found');
          }
          final song = Song.fromJson(data.first as Map<String, dynamic>);
          if (song.downloadUrl == null) {
            throw Exception('No download url found');
          }
          return song;
        },
      ),
    ))
        .$2;
  }

  Future<void> play() async {
    await audioHandler.play();
  }

  Future<void> pause() async {
    await audioHandler.pause();
  }

  Future<void> skipToPrevious() => audioHandler.skipToPrevious();

  Future<void> skipToNext() => audioHandler.skipToNext();

  Future<void> skipToIndex(int index, [bool autoPlay = true]) async {
    await audioHandler.skipToQueueItem(index);
    if (!audioHandler.player.playing && autoPlay) {
      await play();
    }
  }

  Future<void> skipToMediaItem(PlayableMedia mediaItem) async {
    final index = state.queueState.queue.indexOf(mediaItem.toMediaItem());
    if (index == -1) return;
    await skipToIndex(index);
  }

  Future<void> seek(Duration position) {
    return audioHandler.seek(position);
  }

  @override
  FutureOr<void> init() async {
    initcache().then((value) {
      if (value == null) return;
      _box = value;
    });
    audioHandler = await AudioService.init(
      builder: () => AudioHandlerImpl(_configCubit),
      config: const AudioServiceConfig(
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
    audioHandler.playbackState.distinct().listen((state) {
      final playing = state.playing;
      if (!playing) return;
      final position = state.position;
      _configCubit.saveCurrentPosition(position);
    });
    audioHandler.playbackState
        .map((event) => event.queueIndex)
        .distinct()
        .listen((index) {
      if (index != null) {
        final controller = _configCubit.miniPlayerPageController;
        final carouselController = _configCubit.playerPageController;
        _configCubit.saveCurrentPlaylistIndex(index);
        animateToPage(index, controller);
        animateToPage(index, carouselController);
      }
    });
    Rx.combineLatest3(
      audioHandler.player.playingStream,
      audioHandler.mediaItem.stream,
      audioHandler.queueState,
      (playing, mediaItem, queueState) => (playing, mediaItem, queueState),
    ).distinct().listen((value) async {
      PaletteGenerator? palette;
      if (value.$2 != null) {
        palette = await _configCubit
            .generatePalleteGenerator(value.$2?.artUri.toString() ?? '');
      } else {
        palette = null;
      }
      emit(state.copyWith(
        isPlaying: value.$1,
        currentMediaItem: value.$2,
        queueState: value.$3,
        paletteGenerator: palette,
      ));
    });
  }

  @override
  Box get box => _box;

  @override
  String get cacheBoxName => AppStrings.commonCacheBoxName;

  MediaColorPalette? get mediaColorPalette {
    if (state.paletteGenerator == null) return null;
    return MediaColorPalette.fromPaletteGenerator(state.paletteGenerator!);
  }
}
