import 'package:flutter/widgets.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/media_carousel/media_carousel.dart';
import 'package:varanasi_mobile_app/features/search/data/search_result/data.dart';
import 'package:varanasi_mobile_app/features/search/ui/widgets/search_results.dart';

class SearchResultsAll extends SearchResults<AllSearchResult> {
  const SearchResultsAll(super.searchResults, {super.key});

  @override
  Widget build(BuildContext context) {
    final results = searchResults.toMediaPlaylist();
    return SliverList.separated(
      separatorBuilder: (ctx, idx) => const SizedBox(height: 32),
      itemBuilder: (_, i) => MediaCarousel(playlist: results[i]),
      itemCount: results.length,
    );
  }
}
