import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';

class MediaDetailPage extends StatelessWidget {
  const MediaDetailPage({
    required this.image,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    super.key,
  });

  final MediaType type;
  final String image;
  final String id;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 400,
            pinned: true,
            scrolledUnderElevation: 10,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              centerTitle: false,
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Hero(
                tag: id,
                transitionOnUserGestures: true,
                child: CachedNetworkImage(
                  imageUrl: image,
                  cacheKey: id,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ],
      ),
    );
  }
}
