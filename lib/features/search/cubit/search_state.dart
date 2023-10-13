// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

sealed class _SearchState extends Equatable {
  const _SearchState();

  @override
  List<Object?> get props => [];
}

final class SearchState extends _SearchState {
  final bool isFetchingTopSearchResults;
  final TopSearchResult? topSearchResult;

  const SearchState({
    this.topSearchResult,
    this.isFetchingTopSearchResults = false,
  });

  @override
  List<Object?> get props => [topSearchResult, isFetchingTopSearchResults];

  SearchState copyWith({
    TopSearchResult? topSearchResult,
    bool? isFetchingTopSearchResults,
  }) {
    return SearchState(
      topSearchResult: topSearchResult ?? this.topSearchResult,
      isFetchingTopSearchResults:
          isFetchingTopSearchResults ?? this.isFetchingTopSearchResults,
    );
  }
}
