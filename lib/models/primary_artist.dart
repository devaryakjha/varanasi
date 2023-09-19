import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'image.dart';

part 'primary_artist.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class PrimaryArtist extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? url;
  @HiveField(3)
  final List<Image>? image;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final String? role;

  const PrimaryArtist({
    this.id,
    this.name,
    this.url,
    this.image,
    this.type,
    this.role,
  });

  factory PrimaryArtist.fromJson(Map<String, dynamic> json) {
    return _$PrimaryArtistFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PrimaryArtistToJson(this);

  PrimaryArtist copyWith({
    String? id,
    String? name,
    String? url,
    List<Image>? image,
    String? type,
    String? role,
  }) {
    return PrimaryArtist(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      image: image ?? this.image,
      type: type ?? this.type,
      role: role ?? this.role,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, url, image, type, role];
}
