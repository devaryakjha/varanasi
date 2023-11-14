import 'package:flutter/material.dart' hide ScrollPosition;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/search_results.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/trending_searches_carousel.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/slivers/custom_sliver_delegate.dart';

class SearchPage extends HookWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final padding = context.padding;
    final searchResults =
        context.select((SearchCubit cubit) => cubit.state.searchResults);
    final showTrendingSearches = searchResults == null;
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
                onClear: () {
                  context.read<SearchCubit>().clearSearch();
                  controller.clear();
                },
                controller: controller,
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
