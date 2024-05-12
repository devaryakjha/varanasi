import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/features/media_detail/presentation/cubits/artist_detail/artist_detail_cubit.dart';
import 'package:varanasi/app/features/media_detail/presentation/widgets/artist_bio.dart';
import 'package:varanasi/app/features/media_detail/presentation/widgets/artist_details_blocks_view.dart';
import 'package:varanasi/app/features/media_detail/presentation/widgets/media_app_bar.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_card.dart';

class ArtistDetailPage extends StatefulWidget {
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
  State<ArtistDetailPage> createState() => _ArtistDetailPageState();
}

class _ArtistDetailPageState extends State<ArtistDetailPage> {
  late final PageStorageBucket _bucket;

  @override
  void initState() {
    _bucket = PageStorageBucket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final details = context.watch<ArtistDetailCubit>().state;
    return PageStorage(
      bucket: _bucket,
      child: Scaffold(
        body: details.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : DefaultTabController(
                length: details.pagesCount,
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      MediaAppBar(
                        title: widget.title,
                        id: widget.id,
                        image: widget.image,
                        pages: details.pages,
                        showBio: details.showBio,
                      ),
                    ];
                  },
                  body: TabBarView(
                    key: ValueKey('TabBarView__${widget.id}'),
                    children: details.pages.map((e) {
                          if (e.showBlockView) {
                            return ArtistDetailsBlocksView(
                              id: widget.id,
                              blocks: e.blocks,
                              key: ValueKey(
                                'ArtistDetailsBlocksView_${widget.id}',
                              ),
                            );
                          }
                          return ListView.builder(
                            key: PageStorageKey(
                              'media_${widget.id}_${e.sequence}',
                            ),
                            physics: const NeverScrollableScrollPhysics(),
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
                        [
                          if (details.showBio)
                            ArtistBioPage(
                              key: ValueKey('ArtistBioPage_${widget.id}'),
                              bio: details.bio,
                              id: widget.id,
                            ),
                        ],
                  ),
                ),
              ),
      ),
    );
  }
}
