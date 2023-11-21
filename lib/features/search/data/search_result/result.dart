import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

part 'result.g.dart';

@JsonSerializable(explicitToJson: true)
class Result extends PlayableMedia with EquatableMixin {
  final String? id;
  final String? title;
  final List<Image>? image;
  final String? url;
  final String? type;
  final String? language;
  final String? description;
  final int? position;
  final String? singers;

  const Result({
    this.id,
    this.title,
    this.image,
    this.url,
    this.type,
    this.language,
    this.description,
    this.position,
    this.singers,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return _$ResultFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$ResultToJson(this);

  Result copyWith({
    String? id,
    String? title,
    List<Image>? image,
    String? album,
    String? url,
    String? type,
    String? language,
    String? description,
    int? position,
    String? singers,
  }) {
    return Result(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      url: url ?? this.url,
      type: type ?? this.type,
      language: language ?? this.language,
      description: description ?? this.description,
      position: position ?? this.position,
      singers: singers ?? this.singers,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      image,
      url,
      type,
      language,
      description,
      position,
      singers,
    ];
  }

  @override
  String? get artworkUrl => image?.lastOrNull?.link ?? '';

  @override
  String get itemId => itemType.isSong && itemUrl.isNotEmpty
      ? (itemUrl.split('/').lastOrNull ?? id ?? '')
      : (id ?? '');

  @override
  String get itemSubtitle => (description ?? '').sanitize;

  @override
  String get itemTitle => (title ?? '').sanitize;

  @override
  PlayableMediaType get itemType => PlayableMediaType.fromString(type ?? '');

  @override
  String get itemUrl => url ?? '';
}
