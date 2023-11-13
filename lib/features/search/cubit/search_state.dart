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
  albums("Albums");

  const SearchFilter(this.filter);

  final String filter;

  bool get isAll => this == SearchFilter.all;
  bool get isSongs => this == SearchFilter.songs;
  bool get isAlbums => this == SearchFilter.albums;
}

final class SearchState extends _SearchState {
  final bool isFetchingTopSearchResults;
  final bool isSearching;
  final TopSearchResult? topSearchResult;
  final SearchResult? searchResults;
  final SearchFilter filter;
  final String query;

  const SearchState({
    this.topSearchResult,
    this.isFetchingTopSearchResults = false,
    this.searchResults,
    this.isSearching = false,
    this.filter = SearchFilter.all,
    this.query = '',
  });

  @override
  List<Object?> get props => [
        topSearchResult,
        isFetchingTopSearchResults,
        searchResults,
        isSearching,
        filter,
        query,
      ];

  SearchState copyWith({
    bool? isFetchingTopSearchResults,
    bool? isSearching,
    TopSearchResult? topSearchResult,
    SearchResult? searchResults,
    SearchFilter? filter,
    String? query,
  }) {
    return SearchState(
      isFetchingTopSearchResults:
          isFetchingTopSearchResults ?? this.isFetchingTopSearchResults,
      isSearching: isSearching ?? this.isSearching,
      topSearchResult: topSearchResult ?? this.topSearchResult,
      searchResults: searchResults ?? this.searchResults,
      filter: filter ?? this.filter,
      query: query ?? this.query,
    );
  }
}
