import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/shared/domain/entities/image.dart';

part 'image.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ImageModel extends Equatable {
  const ImageModel({required this.quality, required this.link});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return _$ImageModelFromJson(json);
  }

  final String quality;
  final String link;

  Image toEntity() {
    return Image(
      quality: quality,
      link: link,
    );
  }

  Map<String, dynamic> toJson() {
    return _$ImageModelToJson(this);
  }

  @override
  List<Object?> get props => [
        quality,
        link,
      ];
}
