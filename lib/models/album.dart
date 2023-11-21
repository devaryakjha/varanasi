import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

import 'artist.dart';
import 'image.dart';
import 'primary_artist.dart';

part 'album.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Album extends PlayableMedia {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? year;
  @HiveField(3)
  final String? type;
  @HiveField(4)
  final String? playCount;
  @HiveField(5)
  final String? language;
  @HiveField(6)
  final String? explicitContent;
  @HiveField(7)
  final String? url;
  @HiveField(8)
  final List<PrimaryArtist>? primaryArtists;
  @HiveField(9)
  final List<dynamic>? featuredArtists;
  @HiveField(10)
  final List<Artist>? artists;
  @HiveField(11)
  final List<Image>? image;
  @HiveField(12)
  final List<dynamic>? songs;
  @HiveField(13)
  final String? songCount;

  const Album({
    this.id,
    this.name,
    this.year,
    this.type,
    this.playCount,
    this.language,
    this.explicitContent,
    this.url,
    this.primaryArtists,
    this.featuredArtists,
    this.artists,
    this.image,
    this.songs,
    this.songCount,
  });

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  Album copyWith({
    String? id,
    String? name,
    String? year,
    String? type,
    String? playCount,
    String? language,
    String? explicitContent,
    String? url,
    List<PrimaryArtist>? primaryArtists,
    List<dynamic>? featuredArtists,
    List<Artist>? artists,
    List<Image>? image,
    List<dynamic>? songs,
    String? songCount,
  }) {
    return Album(
      id: id ?? this.id,
      name: name ?? this.name,
      year: year ?? this.year,
      type: type ?? this.type,
      playCount: playCount ?? this.playCount,
      language: language ?? this.language,
      explicitContent: explicitContent ?? this.explicitContent,
      url: url ?? this.url,
      primaryArtists: primaryArtists ?? this.primaryArtists,
      featuredArtists: featuredArtists ?? this.featuredArtists,
      artists: artists ?? this.artists,
      image: image ?? this.image,
      songs: songs ?? this.songs,
      songCount: songCount ?? this.songCount,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      year,
      type,
      playCount,
      language,
      explicitContent,
      url,
      primaryArtists,
      featuredArtists,
      artists,
      image,
      songs,
      songCount,
    ];
  }

  @override
  PlayableMediaType get itemType => PlayableMediaType.fromString(type ?? '');

  @override
  String? get artworkUrl => image?.lastOrNull?.link;

  @override
  String get itemId => id ?? '';

  @override
  String get itemSubtitle =>
      '${(type ?? '').capitalize} • ${artists?.map((e) => e.name).join(', ') ?? ''}';

  @override
  String get itemTitle => name ?? '';

  @override
  String get itemUrl => url ?? '';
}
