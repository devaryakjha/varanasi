import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Image extends Equatable {
  @HiveField(0)
  final String? quality;
  @HiveField(1)
  final String? link;

  const Image({this.quality, this.link});

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);

  Image copyWith({
    String? quality,
    String? link,
  }) {
    return Image(
      quality: quality ?? this.quality,
      link: link ?? this.link,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [quality, link];
}
