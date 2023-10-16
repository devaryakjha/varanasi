import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:varanasi_mobile_app/features/home/ui/home_widgets/media_carousel/media_carousel.dart';
import 'package:varanasi_mobile_app/features/search/cubit/search_cubit.dart';
import 'package:varanasi_mobile_app/models/media_playlist.dart';

class TrendingSearchesCarousel extends StatelessWidget {
  const TrendingSearchesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final trendingSearches = context
        .select((SearchCubit cubit) => cubit.state.topSearchResult?.data ?? []);
    return SliverToBoxAdapter(
      child: MediaCarousel(
        playlist: MediaPlaylist(
          mediaItems: trendingSearches,
          title: 'Trending Searches',
        ),
      ),
    );
  }
}
