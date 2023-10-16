// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

sealed class _SearchState extends Equatable {
  const _SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchState extends _SearchState {
  final bool isFetchingTopSearchResults;
  final bool isSearching;
  final TopSearchResult? topSearchResult;
  final SearchResult? searchResults;

  const SearchState({
    this.topSearchResult,
    this.isFetchingTopSearchResults = false,
    this.searchResults,
    this.isSearching = false,
  });

  @override
  List<Object?> get props => [
        topSearchResult,
        isFetchingTopSearchResults,
        searchResults,
        isSearching,
      ];

  SearchState copyWith({
    bool? isFetchingTopSearchResults,
    bool? isSearching,
    TopSearchResult? topSearchResult,
    SearchResult? searchResults,
  }) {
    return SearchState(
      isFetchingTopSearchResults:
          isFetchingTopSearchResults ?? this.isFetchingTopSearchResults,
      isSearching: isSearching ?? this.isSearching,
      topSearchResult: topSearchResult ?? this.topSearchResult,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
