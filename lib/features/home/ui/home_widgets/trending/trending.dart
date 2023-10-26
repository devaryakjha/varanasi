import 'package:flutter/material.dart';
import 'package:varanasi_mobile_app/features/home/data/models/trending.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/helpers/ressponsive_sizer.dart';

import 'item.dart';

const crossAxisSpacing = 8.0;
const mainAxisSpacing = 8.0;
const crossAxisCount = 2;
const cellHeight = 56;

class TrendingSongsList extends StatefulWidget {
  final Trending trending;
  const TrendingSongsList({super.key, required this.trending});

  @override
  State<TrendingSongsList> createState() => _TrendingSongsListState();
}

class _TrendingSongsListState extends State<TrendingSongsList> {
  late final List<PlayableMedia> media;

  @override
  void initState() {
    // get the songs and albums from the trending object
    final songs = widget.trending.songs ?? [];
    final albums = widget.trending.albums ?? [];

    // pick 6 items randomly from songs and albums both
    // and show them in the grid
    // if there are less than 6 items in total, show them all
    // if there are no items, don't show the grid
    media = [...songs, ...albums];
    media.shuffle();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // calculate the aspect ratio of the cell
    final screenWidth = Device.width;

    // 8 is the crossAxisSpacing
    final width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;

    // 56 is the height of the cell
    final aspectRatio = width / cellHeight;

    return Visibility(
      visible: media.isNotEmpty,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: aspectRatio,
        shrinkWrap: true,
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        padding: const EdgeInsets.all(8.0),
        children: media
            .sublist(0, 6)
            .map((e) => TrendingItem(e, key: ObjectKey(e)))
            .toList(),
      ),
    );
  }
}
