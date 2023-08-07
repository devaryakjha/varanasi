import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'download_url.g.dart';

@JsonSerializable()
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
}
