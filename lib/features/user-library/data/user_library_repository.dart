import 'package:hive_flutter/adapters.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';

class UserLibraryRepository {
  UserLibraryRepository._();

  static final UserLibraryRepository _instance = UserLibraryRepository._();

  factory UserLibraryRepository() => _instance;

  late final Box<UserLibrary> _box;

  Box<UserLibrary> get box => _box;

  Future<void> init() async {
    _box = await Hive.openBox<UserLibrary>(AppStrings.userLibraryCacheKey);
  }

  List<UserLibrary> getLibraries() => _box.values.toList();

  bool libraryExists(String id) => _box.containsKey(id);

  Future<void> addLibrary<E extends UserLibrary>(E library) =>
      _box.put(library.id, library);

  Future<void> updateLibrary<E extends UserLibrary>(E library) =>
      _box.put(library.id, library);

  Future<void> deleteLibrary<E extends UserLibrary>(E library) =>
      _box.delete(library.id);

  Future<void> clearLibrary() => _box.clear();

  Future<void> favoriteSong(Song song) async {
    // final favourites = _box.get(
    //   Favorite.boxKey,
    //   defaultValue: Favorite.empty(),
    // )!;
    // final newFavourites = favourites.copyWith(
    //   mediaItems: [...favourites.mediaItems, song],
    // );
    // await _box.put(Favorite.boxKey, newFavourites);
  }

  Future<void> unfavoriteSong(Song song) async {
    // final favourites = _box.get(
    //   Favorite.boxKey,
    //   defaultValue: Favorite.empty(),
    // )!;
    // final newFavourites = favourites.copyWith(
    //   mediaItems: favourites.mediaItems.where((e) => e.id != song.id).toList(),
    // );
    // await _box.put(Favorite.boxKey, newFavourites);
  }
}
