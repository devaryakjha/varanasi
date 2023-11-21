import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/media_carousel/media_carousel.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';
import 'package:varanasi_mobile_app/widgets/shimmer_loader.dart';

class TrendingSearchesCarousel extends StatelessWidget {
  const TrendingSearchesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final (trendingSearches, isFetchingTopSearchResults) = context.select(
        (SearchCubit cubit) => (
              cubit.state.topSearchResult?.data ?? [],
              cubit.state.isFetchingTopSearchResults
            ));
    if (isFetchingTopSearchResults) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 220,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Searches',
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) => ShimmerLoader(
                    height: 120,
                    width: 140,
                    margin: index == 0
                        ? const EdgeInsets.only(left: 8)
                        : index == 19
                            ? const EdgeInsets.only(right: 8)
                            : EdgeInsets.zero,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return SliverToBoxAdapter(
      child: MediaCarousel(
        playlist: MediaPlaylist(
          id: 'trending_searches',
          mediaItems: trendingSearches,
          title: 'Trending Searches',
          url: null,
        ),
      ),
    );
  }
}
