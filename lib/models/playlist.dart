import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

import 'image.dart';

part 'playlist.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Playlist extends PlayableMedia {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? userId;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? subtitle;
  @HiveField(4)
  final String? type;
  @HiveField(5)
  final List<Image>? image;
  @HiveField(6)
  final String? url;
  @HiveField(7)
  final String? songCount;
  @HiveField(8)
  final String? firstname;
  @HiveField(9)
  final String? followerCount;
  @HiveField(10)
  final String? lastUpdated;
  @HiveField(11)
  final String? explicitContent;

  const Playlist({
    this.id,
    this.userId,
    this.title,
    this.subtitle,
    this.type,
    this.image,
    this.url,
    this.songCount,
    this.firstname,
    this.followerCount,
    this.lastUpdated,
    this.explicitContent,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return _$PlaylistFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  Playlist copyWith({
    String? id,
    String? userId,
    String? title,
    String? subtitle,
    String? type,
    List<Image>? image,
    String? url,
    String? songCount,
    String? firstname,
    String? followerCount,
    String? lastUpdated,
    String? explicitContent,
  }) {
    return Playlist(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      type: type ?? this.type,
      image: image ?? this.image,
      url: url ?? this.url,
      songCount: songCount ?? this.songCount,
      firstname: firstname ?? this.firstname,
      followerCount: followerCount ?? this.followerCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      explicitContent: explicitContent ?? this.explicitContent,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      title,
      subtitle,
      type,
      image,
      url,
      songCount,
      firstname,
      followerCount,
      lastUpdated,
      explicitContent,
    ];
  }

  @override
  PlayableMediaType get itemType => PlayableMediaType.fromString(type ?? '');

  @override
  String? get artworkUrl => image?.lastOrNull?.link;

  @override
  String get itemId => id ?? '';

  @override
  String get itemSubtitle => subtitle ?? '';

  @override
  String get itemTitle => title ?? '';

  @override
  String get itemUrl => url ?? '';
}
