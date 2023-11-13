import 'package:flutter/material.dart' hide ScrollPosition;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/search_results.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/trending_searches_carousel.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/slivers/custom_sliver_delegate.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;
    final (searchResults, isSearching) = context.select((SearchCubit cubit) =>
        (cubit.state.searchResults, cubit.state.isSearching));
    final showTrendingSearches = searchResults == null || isSearching;
    return Scaffold(
      body: NotificationListener(
        onNotification: context.read<SearchCubit>().handleScrollUpdate,
        child: CustomScrollView(
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
            if (!showTrendingSearches) SearchResults.fromType(searchResults),
          ],
        ),
      ),
    );
  }
}
