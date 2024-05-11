import 'package:common/common.dart';
import 'package:flutter/widgets.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';

class Block extends Equatable implements Comparable<Block> {
  const Block({
    required this.title,
    required this.children,
    required this.sequence,
    required this.orientation,
  });

  final String title;
  final List<Media> children;
  final int sequence;
  final Axis orientation;

  double get maxHeight {
    return children.reduce(
      (value, element) {
        return value.height > element.height ? value : element;
      },
    ).height;
  }

  double get maxWidth {
    return children.reduce(
      (value, element) {
        return value.width > element.width ? value : element;
      },
    ).width;
  }

  @override
  List<Object?> get props => [title, children, sequence, orientation];

  @override
  int compareTo(Block other) {
    return sequence.compareTo(other.sequence);
  }
}
