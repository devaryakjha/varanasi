import 'package:equatable/equatable.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';

class Block extends Equatable {
  const Block({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Media> children;

  @override
  List<Object?> get props => [title, children];
}
