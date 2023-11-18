import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_url.g.dart';

@HiveType(typeId: 16)
enum DownloadQuality {
  @HiveField(0)
  low("12kbps"),
  @HiveField(1)
  medium("48kbps"),
  @HiveField(2)
  high("96kbps"),
  @HiveField(3)
  veryHigh("160kbps"),
  @HiveField(4)
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

  String get describeQuality => switch (this) {
        DownloadQuality.high => 'Normal',
        DownloadQuality.veryHigh => 'Very High',
        _ => name.capitalize,
      };
}

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 10)
class DownloadUrl extends Equatable {
  @HiveField(0)
  final String? quality;
  @HiveField(1)
  final String? link;

  const DownloadUrl({this.quality, this.link});

  factory DownloadUrl.fromJson(Map<String, dynamic> json) =>
      _$DownloadUrlFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadUrlToJson(this);

  @override
  List<Object?> get props => [quality, link];

  DownloadQuality get dQuality => DownloadQuality.fromString(quality);
}
