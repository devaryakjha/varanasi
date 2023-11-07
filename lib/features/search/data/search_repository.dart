import 'package:hive/hive.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/data/search_data_provider.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/constants/strings.dart';
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

  final Map<String, AllSearchResult> _searchResultsCache = {};

  Future<TopSearchResult?> fetchTopSearchResults() async {
    final (_, searchResults) =
        await SearchDataProvider.instance.fetchTopSearchResults();
    return searchResults;
  }

  Future<AllSearchResult?> triggerSearch(
      String query, SearchFilter filter) async {
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
