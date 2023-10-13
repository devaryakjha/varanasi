import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_url.g.dart';

enum DownloadQuality {
  low("12kbps"),
  medium("48kbps"),
  high("96kbps"),
  veryHigh("160kbps"),
  extreme("320kbps");

  final String quality;

  const DownloadQuality(this.quality);

  factory DownloadQuality.fromString(String? quality) => switch (quality) {
        '12kbps' => DownloadQuality.low,
        '48kbps' => DownloadQuality.medium,
        '96kbps' => DownloadQuality.high,
        '160kbps' => DownloadQuality.veryHigh,
        '320kbps' => DownloadQuality.extreme,
        _ => DownloadQuality.low,
      };
}

@JsonSerializable()
@HiveType(typeId: 10)
class DownloadUrl extends Equatable {
  @HiveField(0)
  final String? _quality;
  @HiveField(1)
  final String? link;

  const DownloadUrl({String? quality, this.link}) : _quality = quality;

  factory DownloadUrl.fromJson(Map<String, dynamic> json) =>
      _$DownloadUrlFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadUrlToJson(this);

  @override
  List<Object?> get props => [_quality, link];

  @HiveField(2)
  DownloadQuality get quality => DownloadQuality.fromString(_quality);
}
