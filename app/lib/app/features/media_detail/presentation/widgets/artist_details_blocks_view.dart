import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';
import 'package:varanasi/app/shared/widgets/block_view.dart';

class ArtistDetailsBlocksView extends StatelessWidget {
  const ArtistDetailsBlocksView({
    required this.blocks,
    required this.id,
    super.key,
  });

  final List<Block> blocks;

  final String id;

  @override
  Widget build(BuildContext context) {
    blocks.sort();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      key: PageStorageKey('blocks_$id'),
      padding: EdgeInsets.zero,
      itemCount: blocks.length + 1,
      itemBuilder: (context, index) {
        if (index == blocks.length) {
          return Gap(context.padding.bottom);
        }
        final block = blocks[index];
        return BlockView(block: block, parentId: id);
      },
    );
  }
}
