import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library_repository.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/app_snackbar.dart';

part 'user_library_state.dart';

class UserLibraryCubit extends AppCubit<UserLibraryState> {
  UserLibraryCubit() : super(UserLibraryInitial());

  UserLibraryRepository get _repository => UserLibraryRepository();

  @override
  FutureOr<void> init() async {
    await _repository.init();
    final library = _repository.getLibraries();
    emit(UserLibraryLoaded(library: library));
  }

  Future<void> favoriteSong(Song song) async {
    await _repository.favoriteSong(song);
    final library = _repository.getLibraries();
    emit(UserLibraryLoaded(library: library));
    AppSnackbar.show("Added to favorites");
  }

  Future<void> unfavoriteSong(Song song) async {
    await _repository.unfavoriteSong(song);
    final library = _repository.getLibraries();
    emit(UserLibraryLoaded(library: library));
    AppSnackbar.show("Removed from favorites");
  }

  Future<void> addToLibrary(MediaPlaylist playlist) async {
    final alreadyExists = _repository.libraryExists(playlist.id!);
    if (alreadyExists) {
      _repository.updateLibrary(playlist.toUserLibrary());
    } else {
      _repository.addLibrary(playlist.toUserLibrary());
      AppSnackbar.show("Added to library");
    }
    final library = _repository.getLibraries();
    emit(UserLibraryLoaded(library: library));
  }

  Future<void> removeFromLibrary(MediaPlaylist playlist) async {
    _repository.deleteLibrary(playlist.toUserLibrary());
    final library = _repository.getLibraries();
    emit(UserLibraryLoaded(library: library));
    AppSnackbar.show("Removed from library");
  }
}
