import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';
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

  Future<void> favoriteSong(Song song) async {
    await _repository.favoriteSong(song);
    AppSnackbar.show("Added to favorites");
  }

  Future<void> unfavoriteSong(Song song) async {
    await _repository.unfavoriteSong(song);
    AppSnackbar.show("Removed from favorites");
  }

  Future<void> addToLibrary(MediaPlaylist playlist) async {
    final alreadyExists = _repository.libraryExists(playlist.id!);
    if (alreadyExists) {
      _repository.updateLibrary(playlist);
    } else {
      _repository.addLibrary(playlist);
      AppSnackbar.show("Added to library");
    }
  }

  Future<void> appendItemToLibrary(MediaPlaylist playlist, Song item) async {
    _repository.appendItemToLibrary(item, playlist.id!);
  }

  Future<void> removeItemFromLibrary(MediaPlaylist playlist, Song item) async {
    _repository.removeItemFromLibrary(item, playlist.id!);
  }

  Future<void> removeFromLibrary(MediaPlaylist playlist) async {
    _repository.deleteLibrary(playlist);
    AppSnackbar.show("Removed from library");
  }

  Future<List<MediaPlaylist>> generateAddToPlaylistSuggestions(
      MediaPlaylist selected) async {
    final currentlibraries = [..._repository.libraries]
        .where((element) => element.id != selected.id)
        .toList();
    final newReleases = await _repository.getNewReleases();
    if (newReleases != null && newReleases.isNotEmpty) {
      currentlibraries.add(newReleases);
    }
    final MediaPlaylist recentMedia = MediaPlaylist(
      url: '',
      title: 'Recent Media',
      description: 'Recently played media',
      id: 'recent-media',
      mediaItems: RecentMediaService.recentMedia
          .map((e) => e.mediaItems ?? [])
          .flattened
          .toList(growable: false),
    );
    currentlibraries.add(recentMedia);
    return currentlibraries.where((element) => element.isNotEmpty).toList();
  }

  MediaPlaylist findPlaylist(MediaPlaylist playlist) =>
      (state as UserLibraryLoaded)
          .library
          .firstWhere((el) => el.id == playlist.id);
}
