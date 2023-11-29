import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/firestore_service.dart';

class UserLibraryRepository with DataProviderProtocol {
  UserLibraryRepository._();

  static final instance = UserLibraryRepository._();

  factory UserLibraryRepository() => instance;

  CollectionReference<Map<String, dynamic>> get _baseCollection =>
      FirestoreService.getUserDocument().collection('user-library');

  final BehaviorSubject<List<MediaPlaylist>> _librariesStream =
      BehaviorSubject.seeded([]);

  Stream<List<MediaPlaylist>> get librariesStream => _librariesStream.stream;
  List<MediaPlaylist> get libraries => _librariesStream.value;

  Future<void> init() async {}

  StreamSubscription? _subscription;

  void setupListeners() {
    _subscription = FirestoreService.getUserDocument()
        .collection('user-library')
        .snapshots()
        .map((event) =>
            event.docs.map(MediaPlaylist.fromFirestore).toList()..sort())
        .listen((event) {
      _librariesStream.add(event);
    });
  }

  void dispose() {
    _subscription?.cancel();
  }

  bool libraryExists(String id) => libraries.any((element) => element.id == id);

  Future<void> addLibrary(MediaPlaylist library) async {
    await _baseCollection.doc(library.id).set(library.toFirestorePayload());
  }

  Future<void> updateLibrary(MediaPlaylist library) async {
    await _baseCollection.doc(library.id).update(library.toFirestorePayload());
  }

  Future<void> appendAllItemToLibrary(
      List<PlayableMedia> item, String playlistId) async {
    await _baseCollection.doc(playlistId).update({
      'mediaItems': FieldValue.arrayUnion(item.map((e) => e.toJson()).toList()),
    });
  }

  Future<void> appendItemToLibrary(
      PlayableMedia item, String playlistId) async {
    await _baseCollection.doc(playlistId).update({
      'mediaItems': FieldValue.arrayUnion([item.toJson()]),
    });
  }

  Future<void> removeItemFromLibrary(
      PlayableMedia item, String playlistId) async {
    await _baseCollection.doc(playlistId).update({
      'mediaItems': FieldValue.arrayRemove([item.toJson()]),
    });
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

  Future<void> favoriteSong(PlayableMedia song) async {
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

  Future<void> unfavoriteSong(PlayableMedia song) async {
    // remove song from favoriteSongs directly in firestore
    await _baseCollection.doc(favouriteSongs.id).update({
      'mediaItems': FieldValue.arrayRemove([song.toJson()]),
    });
  }
}
