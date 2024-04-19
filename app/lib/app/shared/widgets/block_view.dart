import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_view.dart';

class BlockView extends StatelessWidget {
  const BlockView({
    required this.block,
    super.key,
  });

  final Block block;

  @override
  Widget build(BuildContext context) {
    // TODO(Arya): Add view all button implementation
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(16),
        ListTile(
          // onTap: () {},
          title: Text(
            block.title,
            style: context.textTheme.titleMedium,
          ),
          // trailing: const Icon(
          //   Icons.arrow_forward_ios,
          //   size: 18,
          // ),
        ),
        const Gap(16),
        if (block.orientation == Axis.vertical)
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: block.children.length,
            separatorBuilder: (_, __) => const Gap(16),
            itemBuilder: (_, index) {
              final child = block.children[index];
              return VerticalView(media: child);
            },
          ),
        if (block.orientation == Axis.horizontal)
          SizedBox(
            height: block.maxHeight,
            child: ListView.separated(
              findChildIndexCallback: (key) {
                final valueKey = key as ValueKey<String>;
                return block.children.indexWhere(
                  (media) => media.id == valueKey.value,
                );
              },
              scrollDirection: block.orientation,
              itemCount: block.children.length,
              separatorBuilder: (_, __) => const Gap(32),
              itemBuilder: (_, index) {
                final child = block.children[index];
                if (block.orientation == Axis.vertical) {
                  return VerticalView(media: child);
                }
                return HorizontalView(
                  media: child,
                  index: index,
                  total: block.children.length,
                );
              },
            ),
          ),
      ],
    );
  }
}

class VerticalView extends StatelessWidget {
  const VerticalView({
    required this.media,
    super.key,
  });

  final Media media;

  @override
  Widget build(BuildContext context) {
    return MediaTileView(media: media);
  }
}

class HorizontalView extends StatelessWidget {
  const HorizontalView({
    required this.media,
    required this.index,
    required this.total,
    super.key,
  });

  final Media media;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0 ? 16 : 0,
        right: index == total - 1 ? 16 : 0,
      ),
      child: MediaView(media: media),
    );
  }
}
