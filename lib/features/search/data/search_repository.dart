import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/features/search/data/search_data_provider.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
import 'package:varanasi_mobile_app/utils/convert_nested_map.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';
import 'package:varanasi_mobile_app/utils/mixins/cachable_mixin.dart';

import 'search_result/data.dart';

class SearchRepository with CacheableService {
  late final Box _box;

  SearchRepository._();

  static final _instance = SearchRepository._();

  static SearchRepository get instance => _instance;

  @override
  Box get box => _box;

  @override
  String get cacheBoxName => AppStrings.commonCacheBoxName;

  Logger get _logger => Logger.instance;

  final Map<String, SearchResult> _searchResultsCache = {};

  Future<TopSearchResult?> fetchTopSearchResults() async {
    await initcache().then((value) {
      if (value == null) return;
      _box = value;
    });
    final cached = maybeGetCached(AppStrings.topSearchesCacheKey);
    if (cached != null) {
      try {
        final cachemap = convertNestedMap(cached);
        final library =
            SearchDataProvider.instance.parseTopSearchResult(cachemap);
        return library;
      } catch (e) {
        /// If the cached data is corrupted, delete it
        _logger.e(e);
        deleteCache(AppStrings.topSearchesCacheKey);
      }
    }
    final (response, searchResults) =
        await SearchDataProvider.instance.fetchTopSearchResults();
    if (searchResults != null) {
      cache(AppStrings.topSearchesCacheKey, response, const Duration(hours: 1));
    } else {
      throw Exception('Failed to fetch top searches');
    }
    return searchResults;
  }

  Future<SearchResult?> triggerSearch(String query) async {
    final cacheKey = AppStrings.searchResultsCacheKey(query);
    if (_searchResultsCache.containsKey(cacheKey)) {
      return _searchResultsCache[cacheKey];
    }
    final (_, searchResults) =
        await SearchDataProvider.instance.triggerSearch(query);
    if (searchResults != null) {
      _searchResultsCache[cacheKey] = searchResults;
    } else {
      throw Exception('Failed to fetch top searches');
    }
    return searchResults;
  }
}
