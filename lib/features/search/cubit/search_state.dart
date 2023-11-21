// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

sealed class _SearchState extends Equatable {
  const _SearchState();

  @override
  List<Object?> get props => [];
}

enum SearchFilter {
  all("All"),
  songs("Songs"),
  albums("Albums"),
  playlists("Playlists");

  const SearchFilter(this.filter);

  final String filter;

  bool get isAll => this == SearchFilter.all;
  bool get isSongs => this == SearchFilter.songs;
  bool get isAlbums => this == SearchFilter.albums;

  static SearchFilter fromString(String filter) {
    return SearchFilter.values.firstWhere(
      (e) => e.name == filter.toLowerCase(),
      orElse: () => SearchFilter.all,
    );
  }
}

enum ScrollPosition {
  top,
  bottom,
  somewhere;

  bool get isTop => this == ScrollPosition.top;
  bool get isBottom => this == ScrollPosition.bottom;
}

final class SearchState extends _SearchState {
  final bool isFetchingTopSearchResults;
  final bool isSearching;
  final bool isFetchingMore;
  final TopSearchResult? topSearchResult;
  final SearchResult? searchResults;
  final SearchFilter filter;
  final String query;
  final ScrollPosition scrollPosition;

  const SearchState({
    this.topSearchResult,
    this.isFetchingTopSearchResults = false,
    this.searchResults,
    this.isSearching = false,
    this.filter = SearchFilter.all,
    this.query = '',
    this.scrollPosition = ScrollPosition.top,
    this.isFetchingMore = false,
  });

  SearchState cleared() => SearchState(topSearchResult: topSearchResult);

  @override
  List<Object?> get props => [
        topSearchResult,
        isFetchingTopSearchResults,
        searchResults,
        isSearching,
        filter,
        query,
        scrollPosition,
        isFetchingMore,
      ];

  SearchState copyWith({
    bool? isFetchingTopSearchResults,
    bool? isSearching,
    bool? isFetchingMore,
    TopSearchResult? topSearchResult,
    SearchResult? searchResults,
    SearchFilter? filter,
    String? query,
    ScrollPosition? scrollPosition,
  }) {
    return SearchState(
      isFetchingTopSearchResults:
          isFetchingTopSearchResults ?? this.isFetchingTopSearchResults,
      isSearching: isSearching ?? this.isSearching,
      topSearchResult: topSearchResult ?? this.topSearchResult,
      searchResults: searchResults ?? this.searchResults,
      filter: filter ?? this.filter,
      query: query ?? this.query,
      scrollPosition: scrollPosition ?? this.scrollPosition,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}
