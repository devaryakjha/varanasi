import 'package:flutter/foundation.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/configs.dart';
import 'package:varanasi_mobile_app/utils/mixins/repository_protocol.dart';
import 'package:varanasi_mobile_app/utils/services/http_services.dart';

import 'search_result/data.dart';

typedef SearchResponse<T extends SearchResult> = Future<(dynamic, T?)>;
typedef SearchTopResponse = Future<(dynamic, TopSearchResult?)>;

class SearchDataProvider with DataProviderProtocol {
  SearchDataProvider._();

  static final instance = SearchDataProvider._();

  SearchTopResponse fetchTopSearchResults() async {
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

  SearchResponse<AllSearchResult> triggerSearchAll(String query,
      [int page = 1]) async {
    try {
      return await fetch<AllSearchResult?>(
        "${appConfig.endpoint.search.all}?query=${Uri.encodeQueryComponent(query)}",
        options: CommonOptions(
          transformer: (r) =>
              compute((res) => AllSearchResult.fromJson(res), r),
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }

  SearchResponse<SongSearchResult> triggerSearchSongs(String query,
      [int page = 1]) async {
    try {
      return await fetch<SongSearchResult?>(
        "${appConfig.endpoint.search.songs}?query=${Uri.encodeQueryComponent(query)}&n=25&p=$page",
        options: CommonOptions(
          transformer: (r) {
            return compute((res) => SongSearchResult.fromJson(res), r);
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }

  SearchResponse<AlbumSearchResult> triggerSearchAlbums(String query,
      [int page = 1]) async {
    try {
      return await fetch<AlbumSearchResult?>(
        "${appConfig.endpoint.search.albums}?query=${Uri.encodeQueryComponent(query)}&n=25&p=$page",
        options: CommonOptions(
          transformer: (r) {
            return compute((res) => AlbumSearchResult.fromJson(res), r);
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }

  SearchResponse<PlaylistSearchResult> triggerSearchPlaylists(String query,
      [int page = 1]) async {
    try {
      return await fetch<PlaylistSearchResult?>(
        "${appConfig.endpoint.search.playlists}?query=${Uri.encodeQueryComponent(query)}&n=25&p=$page",
        options: CommonOptions(
          transformer: (r) {
            return compute((res) => PlaylistSearchResult.fromJson(res), r);
          },
        ),
      );
    } catch (e) {
      return (e, null);
    }
  }
}
