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

  Future<void> removeFromLibrary(MediaPlaylist playlist) async {
    _repository.deleteLibrary(playlist);
    AppSnackbar.show("Removed from library");
  }

  Future<List<MediaPlaylist>> generateAddToPlaylistSuggestions() async {
    final currentlibraries = _repository.libraries;
    currentlibraries.addAll(RecentMediaService.recentMedia);
    return currentlibraries;
  }
}
