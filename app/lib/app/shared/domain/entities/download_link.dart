import 'package:common/common.dart';

class DownloadLink extends Equatable {
  const DownloadLink({required this.quality, required this.link});

  final String quality;
  final String link;

  @override
  List<Object?> get props => [
        quality,
        link,
      ];
}
