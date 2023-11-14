import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/search/data/search_repository.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/features/search/data/top_search_result/top_search_result.dart';
import 'package:varanasi_mobile_app/utils/app_cubit.dart';
import 'package:varanasi_mobile_app/utils/debounce.dart';
import 'package:varanasi_mobile_app/utils/logger.dart';

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

  void clearSearch() {
    Logger.instance.d('clearing search');
    emit(state.cleared());
  }

  Future<void> triggerSearch(String query) async {
    // debounce the search
    _debounce(() async {
      if (state.isSearching) return;
      final currResults = state.searchResults;
      Logger.instance.d('triggering search $query');
      if (!state.filter.isAll &&
          currResults is PaginatedResult &&
          currResults.type.type == state.filter.filter.toLowerCase() &&
          !currResults.hasNextPage) return;

      final page = switch (currResults) {
        (PaginatedResult curr)
            when curr.type.type == state.filter.filter.toLowerCase() =>
          curr.nextPage,
        (_) => 1,
      };

      emit(state.copyWith(
          isSearching: page == 1, query: query, isFetchingMore: page > 1));
      final results = await repository.triggerSearch(query, state.filter, page);
      if (results != null) {
        if (results is PaginatedResult) {
          if (results.type == currResults?.type) {
            Logger.instance.d('copying from paginated result');
            emit(state.copyWith(
              searchResults: (currResults as PaginatedResult)
                  .copyFromPaginatedResult(results),
              isSearching: false,
              isFetchingMore: false,
            ));
          } else {
            Logger.instance.d('copying from all result ${results.total}');
            emit(state.copyWith(
              searchResults: results,
              isSearching: false,
              isFetchingMore: false,
            ));
          }
        } else {
          Logger.instance.d('copying from all result');
          emit(state.copyWith(
            searchResults: results,
            isSearching: false,
            isFetchingMore: false,
          ));
        }
      } else {
        emit(state.copyWith(
          isSearching: false,
          isFetchingMore: false,
        ));
      }
    });
  }

  void updateFilter(SearchFilter filter) {
    emit(state.copyWith(filter: filter));
  }

  bool handleScrollUpdate(ScrollUpdateNotification notification) {
    if (state.filter.isAll) return false;
    final metrics = notification.metrics;
    final position = metrics.pixels;
    final max = metrics.maxScrollExtent;
    if (position == 0) {
      emit(state.copyWith(scrollPosition: ScrollPosition.top));
    } else if (position == max) {
      emit(state.copyWith(scrollPosition: ScrollPosition.bottom));
      if (!state.filter.isAll) {
        triggerSearch(state.query);
      }
    }
    return true;
  }
}
