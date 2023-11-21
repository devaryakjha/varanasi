import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

part 'top_search.g.dart';

@JsonSerializable()
class TopSearch extends PlayableMedia with EquatableMixin {
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
      _$TopSearchFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TopSearchToJson(this);

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

  @override
  String? get artworkUrl => image?.lastOrNull?.link;

  @override
  String get itemId => itemUrl.isEmpty
      ? (id ?? '')
      : (itemUrl.split('/').lastOrNull ?? id ?? '');

  @override
  String get itemSubtitle => "Top Search • $description";

  @override
  String get itemTitle => title ?? '';

  @override
  PlayableMediaType get itemType => PlayableMediaType.fromString(type ?? '');

  @override
  String get itemUrl => url ?? '';
}
