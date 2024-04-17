import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/shared/domain/entities/media_type.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum MediaTypeModel {
  artist;

  MediaType toEntity() {
    return switch (this) {
      MediaTypeModel.artist => MediaType.artist,
    };
  }
}
