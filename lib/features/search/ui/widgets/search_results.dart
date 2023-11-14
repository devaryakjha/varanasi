import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/search_results_playlists.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/search_results_songs.dart';

import 'search_results_albums.dart';
import 'search_results_all.dart';

abstract class SearchResults<D extends SearchResult> extends StatelessWidget {
  final D searchResults;
  const SearchResults(this.searchResults, {super.key});

  static Widget fromType(SearchResult searchResults) {
    return switch (searchResults) {
      (AllSearchResult r) => SearchResultsAll(r),
      (PaginatedResult r) => switch (r) {
          (SongSearchResult r) => SearchResultsSongs(r),
          (AlbumSearchResult r) => SearchResultsAlbums(r),
          (PlaylistSearchResult r) => SearchResultsPlaylists(r),
        },
    };
  }
}
