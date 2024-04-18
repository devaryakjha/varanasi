import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MediaDetailPage extends StatelessWidget {
  const MediaDetailPage({
    required this.image,
    required this.id,
    super.key,
  });

  final String image;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
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
        ],
      ),
    );
  }
}
