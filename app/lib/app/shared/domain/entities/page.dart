import 'package:common/common.dart';
import 'package:varanasi/app/shared/domain/entities/block.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';

class Page extends Equatable {
  const Page({
    required this.title,
    required this.blocks,
    required this.paginated,
    required this.children,
    required this.sequence,
  });

  final String title;
  final List<Block> blocks;
  final bool paginated;
  final List<Media> children;
  final int sequence;

  bool get showBlockView => blocks.isNotEmpty;

  @override
  List<Object?> get props => [
        title,
        blocks,
        paginated,
        children,
        sequence,
      ];
}
