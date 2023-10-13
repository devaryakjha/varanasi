import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/image.dart';

part 'top_search.g.dart';

@JsonSerializable()
class TopSearch extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final List<Image>? image;
  final String? url;
  final String? type;
  final String? album;

  const TopSearch({
    this.id,
    this.title,
    this.description,
    this.image,
    this.url,
    this.type,
    this.album,
  });

  factory TopSearch.fromJson(Map<String, dynamic> json) =>
      _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);

  TopSearch copyWith({
    String? id,
    String? title,
    String? description,
    List<Image>? image,
    String? url,
    String? type,
    String? album,
  }) {
    return TopSearch(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      url: url ?? this.url,
      type: type ?? this.type,
      album: album ?? this.album,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      description,
      image,
      url,
      type,
      album,
    ];
  }
}
