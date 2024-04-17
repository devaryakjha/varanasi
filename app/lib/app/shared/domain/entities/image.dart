import 'package:equatable/equatable.dart';

class Image extends Equatable {
  const Image({required this.quality, required this.link});

  final String quality;
  final String link;

  @override
  List<Object?> get props => [
        quality,
        link,
      ];
}
