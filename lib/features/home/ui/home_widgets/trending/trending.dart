import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/home/data/models/trending.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/strings.dart';
import 'package:varanasi_mobile_app/utils/extensions/theme.dart';

const crossAxisSpacing = 8.0;
const mainAxisSpacing = 8.0;
const crossAxisCount = 2;
const cellHeight = 56;

class TrendingSongsList extends StatelessWidget {
  final Trending trending;
  const TrendingSongsList({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    // calculate the aspect ratio of the cell
    final screenWidth = MediaQuery.sizeOf(context).width;

    // 8 is the crossAxisSpacing
    final width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    // 56 is the height of the cell
    final aspectRatio = width / cellHeight;

    // get the songs and albums from the trending object
    final songs = trending.songs ?? [];
    final albums = trending.albums ?? [];

    // pick 6 items randomly from songs and albums both
    // and show them in the grid
    // if there are less than 6 items in total, show them all
    // if there are no items, don't show the grid
    final media = [...songs, ...albums];
    media.shuffle();

    return Visibility(
      visible: media.isNotEmpty,
      child: SizedBox(
        height: 56 * 3 + 8 * 2,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: aspectRatio,
          shrinkWrap: true,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          padding: const EdgeInsets.all(8.0),
          children:
              media.map((e) => TrendingItem(e, key: ObjectKey(e))).toList(),
        ),
      ),
    );
  }
}

class TrendingItem extends StatelessWidget {
  final PlayableMedia media;

  const TrendingItem(this.media, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {},
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey.shade900,
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: media.artworkUrl ?? '',
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  media.itemTitle.sanitize,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
