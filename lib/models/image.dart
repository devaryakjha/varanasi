import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true)
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

  static const Image likedSongs = Image(
    quality: '500x500',
    link:
        'https://community.spotify.com/t5/image/serverpage/image-id/104727iC92B541DB372FBC7/image-dimensions/2500?v=v2&px=-1',
  );

  factory Image.fromString(String link) =>
      Image(quality: '500x500', link: link);
}
