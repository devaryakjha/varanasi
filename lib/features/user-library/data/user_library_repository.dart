import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/services/firestore_service.dart';

class UserLibraryRepository {
  UserLibraryRepository._();

  static final instance = UserLibraryRepository._();

  factory UserLibraryRepository() => instance;

  CollectionReference<Map<String, dynamic>> get _baseCollection =>
      FirestoreService.getUserDocument().collection('user-library');

  final BehaviorSubject<List<MediaPlaylist>> librariesStream =
      BehaviorSubject.seeded([]);

  List<MediaPlaylist> get libraries => librariesStream.value;

  Future<void> init() async {}

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  void setupListeners() {
    FirestoreService.getUserDocument()
        .collection('user-library')
        .snapshots()
        .map((event) =>
            event.docs.map(MediaPlaylist.fromFirestore).toList()..sort())
        .pipe(librariesStream);
  }

  void dispose() {
    _subscription?.cancel();
    librariesStream.add([]);
  }

  bool libraryExists(String id) => libraries.any((element) => element.id == id);

  Future<void> addLibrary(MediaPlaylist library) async {
    await _baseCollection.doc(library.id).set(library.toFirestorePayload());
  }

  Future<void> updateLibrary(MediaPlaylist library) async {
    await _baseCollection.doc(library.id).update(library.toFirestorePayload());
  }

  Future<void> deleteLibrary(MediaPlaylist library) async {
    await _baseCollection.doc(library.id).delete();
  }

  MediaPlaylist get favouriteSongs =>
      libraries.firstWhereOrNull((element) => element.isFavorite) ??
      MediaPlaylist(
        type: 'favorite',
        images: const [Image.likedSongs],
        id: "favorite",
        title: "Liked Songs",
        description: "Songs you liked",
        url: null,
      );

  Future<void> favoriteSong(Song song) async {
    try {
      final hasFavoriteSongs = libraries.any((element) => element.isFavorite);
      if (!hasFavoriteSongs) {
        await addLibrary(favouriteSongs.copyWith(mediaItems: [song]));
      }
      // append song to favoriteSongs directly in firestore
      await _baseCollection.doc(favouriteSongs.id).update({
        'mediaItems': FieldValue.arrayUnion([song.toJson()]),
      });
    } catch (e) {
      Logger.instance.d(e.toString());
    }
  }

  Future<void> unfavoriteSong(Song song) async {
    // remove song from favoriteSongs directly in firestore
    await _baseCollection.doc(favouriteSongs.id).update({
      'mediaItems': FieldValue.arrayRemove([song.toJson()]),
    });
  }
}
