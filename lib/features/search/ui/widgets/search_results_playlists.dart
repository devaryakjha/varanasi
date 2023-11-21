import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/utils/routes.dart';
import 'package:varanasi_mobile_app/widgets/media_list.dart';

import 'search_results.dart';

class SearchResultsPlaylists extends SearchResults<PlaylistSearchResult> {
  const SearchResultsPlaylists(super.searchResults, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = searchResults.results ?? [];
    final isFetchingMore =
        context.select((SearchCubit cubit) => cubit.state.isFetchingMore);
    return MediaListView.sliver(
      items,
      isPlaying: false,
      isItemPlaying: (media) => false,
      onItemTap: (index, media) {
        context.pushNamed(
          AppRoutes.library.name,
          extra: media,
          pathParameters: {'id': media.itemId},
        );
      },
      loading: isFetchingMore,
    );
  }
}
