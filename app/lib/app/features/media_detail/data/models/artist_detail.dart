import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi/app/features/media_detail/data/models/artist_bio.dart';
import 'package:varanasi/app/features/media_detail/domain/entities/artist_detail.dart';
import 'package:varanasi/app/shared/data/models/page.dart';

part 'artist_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ArtistDetailsModel extends Equatable {
  const ArtistDetailsModel({
    required this.name,
    required this.id,
    required this.pages,
    required this.bio,
  });

  const ArtistDetailsModel.empty()
      : name = '',
        id = '',
        pages = const [],
        bio = const [];

  factory ArtistDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistDetailsModelFromJson(json);

  final String name;
  final String id;
  @JsonKey(defaultValue: [])
  final List<PageModel> pages;
  @JsonKey(defaultValue: [])
  final List<BioModel> bio;

  Map<String, dynamic> toJson() => _$ArtistDetailsModelToJson(this);

  ArtistDetails toEntity() => ArtistDetails(
        name: name,
        id: id,
        pages: pages.map((e) => e.toEntity()).toList(),
        bio: bio.map((e) => e.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [name, id, pages, bio];
}
