import 'package:equatable/equatable.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';

class Block extends Equatable {
  const Block({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Media> children;

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
  List<Object?> get props => [title, children];
}
