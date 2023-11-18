import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/features/user-library/data/user_library.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/services/firestore_service.dart';

class UserLibraryRepository {
  UserLibraryRepository._();

  static final instance = UserLibraryRepository._();

  factory UserLibraryRepository() => instance;

  CollectionReference<Map<String, dynamic>> get _baseCollection =>
      FirestoreService.getUserDocument().collection('user-library');

  BehaviorSubject<List<UserLibrary>> librariesStream =
      BehaviorSubject.seeded([]);

  List<UserLibrary> get libraries => librariesStream.value;

  Future<void> init() async {
    FirestoreService.getUserDocument()
        .collection('user-library')
        .get()
        .then((value) {
      final libraries =
          value.docs.map((e) => UserLibrary.fromFirestore(e)).toList();
      librariesStream.value = libraries;
    });
    FirestoreService.getUserDocument()
        .collection('user-library')
        .snapshots()
        .listen((event) {
      for (var element in event.docChanges) {
        final library = UserLibrary.fromFirestore(element.doc);
        if (element.type == DocumentChangeType.added) {
          librariesStream.value = [...librariesStream.value, library];
        } else if (element.type == DocumentChangeType.modified) {
          librariesStream.value = [
            ...librariesStream.value
                .where((element) => element.id != library.id),
            library
          ];
        } else if (element.type == DocumentChangeType.removed) {
          librariesStream.value = [
            ...librariesStream.value
                .where((element) => element.id != library.id),
          ];
        }
      }
    });
  }

  bool libraryExists(String id) => libraries.any((element) => element.id == id);

  Future<void> addLibrary<E extends UserLibrary>(E library) async {
    await _baseCollection.doc(library.id).set(library.toFirestorePayload());
  }

  Future<void> updateLibrary<E extends UserLibrary>(E library) async {
    await _baseCollection.doc(library.id).update(library.toFirestorePayload());
  }

  Future<void> deleteLibrary<E extends UserLibrary>(E library) async {
    await _baseCollection.doc(library.id).delete();
  }

  UserLibrary get favouriteSongs =>
      libraries.firstWhereOrNull((element) => element.isFavorite) ??
      const UserLibrary(
        type: UserLibraryType.favorite,
        images: [Image.likedSongs],
        id: "favorite",
        title: "Liked Songs",
        description: "Songs you liked",
      );

  Future<void> favoriteSong(PlayableMedia song) async {
    try {
      final hasFavoriteSongs = libraries.any((element) => element.isFavorite);
      if (!hasFavoriteSongs) {
        await addLibrary(favouriteSongs);
      }
      // append song to favoriteSongs directly in firestore
      await _baseCollection.doc(favouriteSongs.id).update({
        'mediaItems': FieldValue.arrayUnion(
          [song.toPlayableMediaImpl().toFirestorePayload()],
        ),
      });
    } catch (e) {
      Logger.instance.d(e.toString());
    }
  }

  Future<void> unfavoriteSong(PlayableMedia song) async {
    // remove song from favoriteSongs directly in firestore
    await _baseCollection.doc(favouriteSongs.id).update({
      'mediaItems': FieldValue.arrayRemove(
        [song.toPlayableMediaImpl().toFirestorePayload()],
      ),
    });
  }
}
