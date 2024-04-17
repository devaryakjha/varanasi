import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';
import 'package:varanasi/app/shared/widgets/media_views/media_view.dart';

class BlockView extends StatelessWidget {
  const BlockView({
    required this.block,
    super.key,
  });

  final Block block;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(16),
        ListTile(
          onTap: () {},
          title: Text(
            block.title,
            style: context.textTheme.titleMedium,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
          ),
        ),
        const Gap(16),
        SizedBox(
          height: block.maxHeight,
          child: ListView.separated(
            findChildIndexCallback: (key) {
              final valueKey = key as ValueKey<String>;
              return block.children.indexWhere(
                (media) => media.id == valueKey.value,
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: block.children.length,
            separatorBuilder: (_, __) => const Gap(32),
            itemBuilder: (_, index) {
              final child = block.children[index];
              return Padding(
                key: ValueKey(child.id),
                padding: EdgeInsets.only(
                  left: index == 0 ? 16 : 0,
                  right: index == block.children.length - 1 ? 16 : 0,
                ),
                child: MediaView(media: child),
              );
            },
          ),
        ),
      ],
    );
  }
}
