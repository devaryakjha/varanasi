import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui/ui.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';
import 'package:varanasi/app/shared/widgets/block_view.dart';

class ArtistDetailsBlocksView extends StatelessWidget {
  const ArtistDetailsBlocksView({required this.blocks, super.key});

  final List<Block> blocks;

  @override
  Widget build(BuildContext context) {
    blocks.sort();
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: blocks.length + 1,
      itemBuilder: (context, index) {
        if (index == blocks.length) {
          return Gap(context.padding.bottom);
        }
        final block = blocks[index];
        return BlockView(block: block);
      },
    );
  }
}
