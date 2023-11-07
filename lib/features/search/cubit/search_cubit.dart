import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:varanasi_mobile_app/features/search/data/search_repository.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/debounce.dart';

part 'search_state.dart';

class SearchCubit extends AppCubit<SearchState> {
  SearchCubit() : super(const SearchState());

  SearchRepository get repository => SearchRepository.instance;

  final Debounce _debounce = Debounce(const Duration(milliseconds: 500));

  @override
  FutureOr<void> init() async {
    await fetchTopSearchResults();
    stream.map((e) => e.filter).distinct().listen((filter) {
      if (state.query.isNotEmpty) {
        triggerSearch(state.query);
      }
    });
  }

  Future<void> fetchTopSearchResults() async {
    emit(state.copyWith(isFetchingTopSearchResults: true));
    final results = await repository.fetchTopSearchResults();
    if (results != null) {
      emit(state.copyWith(
        topSearchResult: results,
        isFetchingTopSearchResults: false,
      ));
    }
  }

  Future<void> triggerSearch(String query) async {
    // debounce the search
    _debounce(() async {
      if (state.isSearching) return;
      emit(state.copyWith(isSearching: true, query: query));
      final results = await repository.triggerSearch(query, state.filter);
      if (results != null) {
        emit(state.copyWith(searchResults: results));
      }
      emit(state.copyWith(isSearching: false));
    });
  }

  void updateFilter(SearchFilter filter) {
    emit(state.copyWith(filter: filter));
  }
}
