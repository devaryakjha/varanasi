import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/shared/domain/entities/download_link.dart';

part 'download_link.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DownloadLinkModel extends Equatable {
  const DownloadLinkModel({required this.quality, required this.link});

  factory DownloadLinkModel.fromJson(Map<String, dynamic> json) {
    return _$DownloadLinkModelFromJson(json);
  }

  final String quality;
  final String link;

  Map<String, dynamic> toJson() {
    return _$DownloadLinkModelToJson(this);
  }

  DownloadLink toEntity() {
    return DownloadLink(
      quality: quality,
      link: link,
    );
  }

  @override
  List<Object?> get props => [
        quality,
        link,
      ];
}
