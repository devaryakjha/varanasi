import 'package:rxdart/rxdart.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/services/firestore_service.dart';

class RecentMediaService {
  RecentMediaService._();

  static final RecentMediaService instance = RecentMediaService._();

  static bool initialized = false;

  static void init() {
    if (initialized) return;
    initialized = true;
    watchRecentMedia().pipe(_recentMediaSubject);
  }

  static final BehaviorSubject<List<MediaPlaylist>> _recentMediaSubject =
      BehaviorSubject<List<MediaPlaylist>>.seeded([]);

  static Stream<List<MediaPlaylist>> get recentMediaStream =>
      _recentMediaSubject.stream;

  static List<MediaPlaylist> get recentMedia => _recentMediaSubject.value;

  static Stream<List<MediaPlaylist>> watchRecentMedia() {
    return FirestoreService.getUserDocument()
        .collection('recent_media')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map(MediaPlaylist.fromFirestore).toList());
  }

  static void addToRecentlyPlayed(MediaPlaylist media) {
    if (recentMedia.any((element) => element.id == media.id)) {
      return;
    }
    FirestoreService.getUserDocument()
        .collection('recent_media')
        .doc(media.id)
        .set(media.toFirestorePayload(media.isSong));
  }
}
