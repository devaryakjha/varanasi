import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

import 'search_result/data.dart';

class SearchDataProvider with DataProviderProtocol {
  SearchDataProvider._();

  static final instance = SearchDataProvider._();

  Future<(dynamic, TopSearchResult?)> fetchTopSearchResults() async {
    try {
      return await fetch<TopSearchResult?>(
        appConfig.endpoint.search.topSearches,
        options: CommonOptions(
          transformer: (response) async {
            final response1 = await compute(parseTopSearchResult, response);
            return response1;
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }

  TopSearchResult parseTopSearchResult(dynamic json) {
    return json is List
        ? TopSearchResult.fromJson({"data": json})
        : TopSearchResult.fromJson(json);
  }

  Future<(dynamic, SearchResult?)> triggerSearch(String query) async {
    try {
      return await fetch<SearchResult?>(
        "${appConfig.endpoint.search.all}?query=${Uri.encodeQueryComponent(query)}",
        options: CommonOptions(
          transformer: (response) async {
            return await compute((res) => SearchResult.fromJson(res), response);
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }
}
