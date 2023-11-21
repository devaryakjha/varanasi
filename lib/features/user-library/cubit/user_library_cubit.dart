import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/cubits/player/player_cubit.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/data/search_repository.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
import 'package:varanasi_mobile_app/utils/helpers/get_app_context.dart';
import 'package:varanasi_mobile_app/utils/services/new_releases_service.dart';
import 'package:varanasi_mobile_app/utils/services/recent_media_service.dart';

part 'user_library_state.dart';

class UserLibraryCubit extends AppCubit<UserLibraryState> {
  UserLibraryCubit() : super(UserLibraryInitial());

  UserLibraryRepository get _repository => UserLibraryRepository();

  @override
  FutureOr<void> init() async {}

  StreamSubscription<List<MediaPlaylist>>? _subscription;

  void setupListeners() {
    _subscription = _repository.librariesStream.listen((event) {
      emit(UserLibraryLoaded(library: event));
    });
    _repository.setupListeners();
  }

  void disposeListeners() {
    _subscription?.cancel();
    _repository.dispose();
  }

  Future<void> favoriteSong(PlayableMedia song) async {
    await _repository.favoriteSong(song);
    AppSnackbar.show("Added to favorites");
  }

  Future<void> unfavoriteSong(PlayableMedia song) async {
    await _repository.unfavoriteSong(song);
    AppSnackbar.show("Removed from favorites");
  }

  Future<void> addToLibrary(MediaPlaylist playlist) async {
    final alreadyExists = _repository.libraryExists(playlist.id);
    if (alreadyExists) {
      _repository.updateLibrary(playlist);
    } else {
      _repository.addLibrary(playlist);
      AppSnackbar.show("Added to library");
    }
  }

  Future<void> appendAllItemToLibrary(
      MediaPlaylist playlist, List<PlayableMedia> item) async {
    final List<Future<Song?>> futures = item.map((e) async {
      if (e is Song) return e;
      return appContext.read<MediaPlayerCubit>().fetchSong(e);
    }).toList();
    final songs =
        (await Future.wait(futures)).whereNotNull().toList(growable: false);
    _repository.appendAllItemToLibrary(songs, playlist.id);
    AppSnackbar.show("Added ${item.length} items to ${playlist.title}");
  }

  Future<void> appendItemToLibrary(
      MediaPlaylist playlist, PlayableMedia item) async {
    final song = item is Song
        ? item
        : await appContext.read<MediaPlayerCubit>().fetchSong(item);
    if (song == null) return;
    _repository.appendItemToLibrary(song, playlist.id);
    AppSnackbar.show("Added ${song.itemTitle} to ${playlist.title}");
  }

  Future<void> removeItemFromLibrary(
      MediaPlaylist playlist, PlayableMedia item) async {
    final song = item is Song
        ? item
        : await appContext.read<MediaPlayerCubit>().fetchSong(item);
    if (song == null) return;
    _repository.removeItemFromLibrary(item, playlist.id);
    AppSnackbar.show("Removed ${item.itemTitle} from ${playlist.title}");
  }

  Future<void> removeFromLibrary(MediaPlaylist playlist) async {
    _repository.deleteLibrary(playlist);
    AppSnackbar.show("Removed from library");
  }

  Future<List<MediaPlaylist>> generateAddToPlaylistSuggestions(
      [String query = ""]) async {
    final List<MediaPlaylist> currentlibraries = [];
    await NewReleasesService.instance.nestedFetchNewsReleases();
    if (query.isNotEmpty) {
      final suggestionOnName = await SearchRepository.instance
          .triggerSearch(query, SearchFilter.songs);
      if (suggestionOnName is SongSearchResult) {
        currentlibraries.add(
          MediaPlaylist(
            id: 'suggestions_on_name_$query',
            mediaItems: suggestionOnName.results,
            title: 'Suggestions based on name',
            description: 'Suggestions based on name',
            url: null,
            images: const [],
          ),
        );
      }
    }

    final newReleases = NewReleasesService.instance.newReleases;
    if (newReleases.isNotEmpty) {
      currentlibraries.addAll(newReleases);
    }
    final recentMedia = MediaPlaylist(
      url: '',
      title: 'Recent Media',
      description: 'Recently played media',
      id: 'recent-media',
      mediaItems: RecentMediaService.recentMedia
          .map((e) => e.mediaItems ?? [])
          .flattened
          .toList(growable: false),
    );
    currentlibraries.insert(0, recentMedia);
    return currentlibraries.where((element) => element.isNotEmpty).toList();
  }

  MediaPlaylist findPlaylist(MediaPlaylist playlist) =>
      (state as UserLibraryLoaded)
          .library
          .firstWhere((el) => el.id == playlist.id);
}
