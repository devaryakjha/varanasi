import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/features/media_detail/presentation/cubits/artist_detail/artist_detail_cubit.dart';
import 'package:varanasi/app/features/media_detail/presentation/widgets/artist_bio.dart';
import 'package:varanasi/app/features/media_detail/presentation/widgets/artist_details_blocks_view.dart';
import 'package:varanasi/app/features/media_detail/presentation/widgets/media_app_bar.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';

class ArtistDetailPage extends StatelessWidget {
  const ArtistDetailPage({
    required this.image,
    required this.id,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String image;
  final String id;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final details = context.watch<ArtistDetailCubit>().state;
    return Scaffold(
      body: details.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: details.pagesCount,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    MediaAppBar(
                      title: title,
                      id: id,
                      image: image,
                      pages: details.pages,
                      showBio: details.showBio,
                    ),
                  ];
                },
                body: TabBarView(
                  children: details.pages.map((e) {
                        if (e.showBlockView) {
                          return ArtistDetailsBlocksView(blocks: e.blocks);
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: e.children.length + 1,
                          itemBuilder: (context, index) {
                            if (index == e.children.length) {
                              return Gap(context.padding.bottom);
                            }
                            final media = e.children[index];
                            return MediaTile.fromMedia(media);
                          },
                        );
                      }).toList() +
                      [if (details.showBio) ArtistBioPage(bio: details.bio)],
                ),
              ),
            ),
    );
  }
}
