import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/image.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

part 'chart.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class Chart extends PlayableMedia {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? subtitle;
  @HiveField(3)
  final String? type;
  @HiveField(4)
  final List<Image>? image;
  @HiveField(5)
  final String? url;
  @HiveField(6)
  final String? firstname;
  @HiveField(7)
  final String? explicitContent;
  @HiveField(8)
  final String? language;

  const Chart({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.image,
    this.url,
    this.firstname,
    this.explicitContent,
    this.language,
  });

  factory Chart.fromJson(Map<String, dynamic> json) => _$ChartFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChartToJson(this);

  Chart copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? type,
    List<Image>? image,
    String? url,
    String? firstname,
    String? explicitContent,
    String? language,
  }) {
    return Chart(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      url: url ?? this.url,
      firstname: firstname ?? this.firstname,
      explicitContent: explicitContent ?? this.explicitContent,
      language: language ?? this.language,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      title,
      subtitle,
      type,
      image,
      url,
      firstname,
      explicitContent,
      language,
    ];
  }

  @override
  PlayableMediaType get itemType => PlayableMediaType.playlist;

  @override
  String? get artworkUrl => image?.lastOrNull?.link;

  @override
  String get itemId => id ?? '';

  @override
  String get itemSubtitle =>
      '${(type ?? '').capitalize} • ${(firstname ?? '').capitalize}';

  @override
  String get itemTitle => title ?? '';

  @override
  String get itemUrl => url ?? '';
}
