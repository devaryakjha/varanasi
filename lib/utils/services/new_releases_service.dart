import 'package:rxdart/subjects.dart';
import 'package:varanasi_mobile_app/features/library/data/library_repository.dart';
import 'package:varanasi_mobile_app/models/album.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/types/types.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/parsers.dart';
import 'package:varanasi_mobile_app/utils/select_random.dart';

import 'http_services.dart';

class NewReleasesService with DataProviderProtocol {
  NewReleasesService._();

  static final NewReleasesService instance = NewReleasesService._();

  final BehaviorSubject<MediaPlaylist?> _newReleaseStream =
      BehaviorSubject.seeded(null);

  /// Stream of new releases
  Stream<MediaPlaylist?> get newReleaseStream => _newReleaseStream.stream;

  /// List of new releases
  MediaPlaylist? get newRelease => _newReleaseStream.value;

  final BehaviorSubject<List<MediaPlaylist>> _newReleasesStream =
      BehaviorSubject.seeded([]);

  /// Stream of new releases
  Stream<List<MediaPlaylist>> get newReleasesStream =>
      _newReleasesStream.stream;

  /// List of new releases
  List<MediaPlaylist> get newReleases => _newReleasesStream.value;

  Future<void> fetchNewReleases([int page = 1]) async {
    final (_, item) = await fetch(
      '${appConfig.endpoint.newReleases}?n=50&p=$page',
      options: CommonOptions(transformer: (data) {
        final JSONList allResults = (data["results"] as List<dynamic>)
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        final parsed = parsePlayableMediaList(allResults);
        return MediaPlaylist(
          id: "new-releases",
          title: "New Releases",
          description: "New releases",
          url: null,
          mediaItems: parsed,
        );
      }),
    );

    _newReleaseStream.add(item);
  }

  Future<void> nestedFetchNewsReleases() async {
    final item = newRelease;
    final allSongs = item?.copyWith(
      id: "new-releases-songs",
      title: "New releases (Songs)",
      description: "New releases (Songs)",
      mediaItems: (item.mediaItems ?? []).whereType<Song>().toList(),
    );
    if (allSongs != null) {
      _newReleasesStream.add([allSongs]);
    }

    final allAlbums = (item?.mediaItems ?? []).whereType<Album>().toList();
    // select 4 random albums
    final random4 = selectRandom(allAlbums, 4);
    final allAlbumRequest =
        random4.map(LibraryRepository.instance.fetchLibrary);
    final allAlsbumResponse = await Future.wait(allAlbumRequest);
    _newReleasesStream.add([
      ..._newReleasesStream.value,
      ...allAlsbumResponse.whereType<MediaPlaylist>(),
    ]);
  }
}
