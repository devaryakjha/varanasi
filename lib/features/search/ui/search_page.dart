import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/media_carousel/media_carousel.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/trending_searches_carousel.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/slivers/custom_sliver_delegate.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;
    final searchResults =
        context.select((SearchCubit cubit) => cubit.state.searchResults);
    final isSearching =
        context.select((SearchCubit cubit) => cubit.state.isSearching);
    final showTrendingSearches = searchResults == null || isSearching;
    final results = searchResults?.toMediaPlaylist() ?? [];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderDelegate(
              padding: padding,
              onSearch: context.read<SearchCubit>().triggerSearch,
              showFilter: !showTrendingSearches,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 32)),
          if (showTrendingSearches) const TrendingSearchesCarousel(),
          if (!showTrendingSearches)
            SliverList.separated(
              separatorBuilder: (ctx, idx) => const SizedBox(height: 32),
              itemBuilder: (_, i) => MediaCarousel(playlist: results[i]),
              itemCount: results.length,
            ),
        ],
      ),
    );
  }
}
