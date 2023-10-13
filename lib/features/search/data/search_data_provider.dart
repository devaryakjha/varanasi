import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

class SearchDataProvider with DataProviderProtocol {
  SearchDataProvider._();

  static final instance = SearchDataProvider._();

  Future<(dynamic, TopSearchResult?)> fetchTopSearchResults() async {
    try {
      return await fetch(
        appConfig.endpoint.search.topSearches,
        options: CommonOptions(
          transformer: (response) async {
            final response1 = await compute(
                parseTopSearchResult, response as Map<String, dynamic>);
            return response1;
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }

  TopSearchResult parseTopSearchResult(Map<String, dynamic> json) =>
      TopSearchResult.fromJson(json);
}
