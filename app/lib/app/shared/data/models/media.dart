import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/shared/data/models/download_link.dart';
import 'package:varanasi/app/shared/data/models/image.dart';
import 'package:varanasi/app/shared/data/models/media_type.dart';
import 'package:varanasi/app/shared/domain/entities/media.dart';

part 'media.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MediaModel extends Equatable {
  const MediaModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.type,
    required this.images,
    required this.token,
    required this.downloadLinks,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return _$MediaModelFromJson(json);
  }

  final String id;
  final String title;
  final String subTitle;
  final String token;
  final MediaTypeModel type;
  final List<ImageModel> images;
  @JsonKey(defaultValue: [])
  final List<DownloadLinkModel> downloadLinks;

  Media toEntity() {
    return Media(
      id: id,
      title: title,
      subTitle: subTitle,
      type: type.toEntity(),
      images: images.map((e) => e.toEntity()).toList(),
      token: token,
      downloadLinks: downloadLinks.map((e) => e.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return _$MediaModelToJson(this);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        subTitle,
        type,
        images,
        token,
        downloadLinks,
      ];
}
