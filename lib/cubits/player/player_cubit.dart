import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/mixins/cachable_mixin.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/player/audio_handler_impl.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

part 'player_state.dart';

extension MediaPlayerCubitExtension on BuildContext {
  MediaPlayerCubit get readMediaPlayerCubit => read<MediaPlayerCubit>();
  MediaPlayerCubit get selectMediaPlayerCubit => watch<MediaPlayerCubit>();
}

class MediaPlayerCubit extends AppCubit<MediaPlayerState>
    with DataProviderProtocol, CacheableService {
  late final AudioHandlerImpl audioHandler;
  late final Box _box;

  MediaPlayerCubit() : super(const MediaPlayerState());

  Future<void> playFromMediaPlaylist<T extends PlayableMedia>(
    MediaPlaylist<T> playlist, [
    int? startIndex,
  ]) async {
    if (playlist.id == state.currentPlaylist && !audioHandler.player.playing) {
      if (startIndex != null) {
        await skipToIndex(startIndex);
      } else {
        await play();
      }
      return;
    }
    emit(state.copyWith(currentPlaylist: playlist.id));
    await audioHandler.updateQueue(playlist.mediaItemsAsMediaItems);
    if (startIndex != null) {
      await skipToIndex(startIndex);
    } else {
      await play();
    }
  }

  Future<void> playFromSong(PlayableMedia media) async {
    assert(media.itemType == PlayableMediaType.song, 'Media must be a song');

    final cached = maybeGetCached<Song>(media.cacheKey);

    if (cached != null) {
      await playFromMediaPlaylist(cached.toMediaPlaylist<Song>());
      return;
    }

    final response = await fetchUri(
      media.moreInfoUrl,
      options: CommonOptions(
        transformer: (response) {
          final data = response as List<dynamic>;
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
    );
    final song = response.$2!;
    cache(media.cacheKey, song);
    await playFromMediaPlaylist(song.toMediaPlaylist<Song>());
  }

  Future<void> play() async {
    await audioHandler.play();
  }

  Future<void> pause() async {
    await audioHandler.pause();
  }

  Future<void> skipToIndex(int index) async {
    await audioHandler.skipToQueueItem(index);
    if (!audioHandler.player.playing) {
      await play();
    }
  }

  @override
  FutureOr<void> init() async {
    initcache().then((value) {
      if (value == null) return;
      _box = value;
    });
    audioHandler = await AudioService.init(
      builder: () => AudioHandlerImpl(),
      config: const AudioServiceConfig(
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );
    Rx.combineLatest2(
      audioHandler.player.playingStream,
      audioHandler.mediaItem.stream,
      (playing, mediaItem) => (playing, mediaItem),
    ).distinct().listen((value) {
      emit(state.copyWith(
        isPlaying: value.$1,
        currentMediaItem: value.$2,
      ));
    });
  }

  @override
  Box get box => _box;

  @override
  String get cacheBoxName => AppStrings.commonCacheBoxName;
}
