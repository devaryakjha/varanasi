import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/trending_searches_carousel.dart';
import 'package:varanasi_mobile_app/utils/extensions/media_query.dart';
import 'package:varanasi_mobile_app/widgets/slivers/custom_sliver_delegate.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.padding;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: CustomHeaderDelegate(padding: padding),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 32)),
          const TrendingSearchesCarousel(),
        ],
      ),
    );
  }
}
