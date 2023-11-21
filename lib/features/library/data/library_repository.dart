import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/features/library/data/library_data_provider.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/models/song.dart';
import 'package:varanasi_mobile_app/utils/constants/constants.dart';
import 'package:varanasi_mobile_app/utils/convert_nested_map.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/mixins/cachable_mixin.dart';

class LibraryRepository with CacheableService {
  late final Box _box;

  LibraryRepository._();

  static final instance = LibraryRepository._();

  @override
  Box get box => _box;

  @override
  String get cacheBoxName => AppStrings.commonCacheBoxName;

  Logger get _logger => Logger.instance;

  Future<MediaPlaylist<Song>> fetchLibrary(PlayableMedia media) async {
    await initcache().then((value) {
      try {
        if (value == null) return;
        _box = value;
      } catch (e) {
        _logger.e(e);
      }
    });
    final cached = maybeGetCached(media.cacheKey);
    if (cached != null) {
      try {
        final cachemap = convertNestedMap(cached['data']);
        final library =
            LibraryDataProvider.instance.parseMediaPlaylist(cachemap);
        return library;
      } catch (e) {
        /// If the cached data is corrupted, delete it
        _logger.e(e);
        deleteCache(media.cacheKey);
      }
    }
    final (response, library) =
        await LibraryDataProvider.instance.fetchLibrary(media);
    if (library != null) {
      cache(media.cacheKey, response);
    } else {
      throw Exception('Failed to fetch library');
    }
    return library;
  }
}
