// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:varanasi_mobile_app/models/song.dart';

part 'download.g.dart';

@HiveType(typeId: 17)
final class DownloadedMedia extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Song media;
  @HiveField(2)
  final String path;
  @HiveField(3)
  final double progress;
  @HiveField(4)
  final bool downloadComplete;
  @HiveField(5)
  final bool downloading;

  const DownloadedMedia({
    required this.id,
    required this.media,
    required this.path,
    this.progress = 0,
    this.downloadComplete = false,
    this.downloading = false,
  });

  @override
  List<Object?> get props =>
      [media, progress, path, downloadComplete, id, downloading];

  @override
  bool get stringify => true;

  DownloadedMedia copyWith({
    String? id,
    Song? media,
    String? path,
    double? progress,
    bool? downloadComplete,
    bool? downloading,
  }) {
    return DownloadedMedia(
      id: id ?? this.id,
      media: media ?? this.media,
      path: path ?? this.path,
      progress: progress ?? this.progress,
      downloadComplete: downloadComplete ?? this.downloadComplete,
      downloading: downloading ?? this.downloading,
    );
  }
}
