import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';

import 'album.dart';
import 'image.dart';
import 'primary_artist.dart';

part 'songs.g.dart';

@JsonSerializable()
@HiveType(typeId: 8)
class Song extends PlayableMedia {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? type;
  @HiveField(3)
  final Album? album;
  @HiveField(4)
  final String? year;
  @HiveField(5)
  final String? releaseDate;
  @HiveField(6)
  final String? duration;
  @HiveField(7)
  final String? label;
  @HiveField(8)
  final List<PrimaryArtist>? primaryArtists;
  @HiveField(9)
  final List<dynamic>? featuredArtists;
  @HiveField(10)
  final String? explicitContent;
  @HiveField(11)
  final String? playCount;
  @HiveField(12)
  final String? language;
  @HiveField(13)
  final String? url;
  @HiveField(14)
  final List<Image>? image;

  const Song({
    this.id,
    this.name,
    this.type,
    this.album,
    this.year,
    this.releaseDate,
    this.duration,
    this.label,
    this.primaryArtists,
    this.featuredArtists,
    this.explicitContent,
    this.playCount,
    this.language,
    this.url,
    this.image,
  }) : super(
          itemId: id ?? '',
          itemTitle: name ?? '',
          itemSubtitle: '',
          itemUrl: url ?? '',
        );

  factory Song.fromJson(Map<String, dynamic> json) {
    return _$SongFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SongToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        album,
        year,
        releaseDate,
        duration,
        label,
        primaryArtists,
        featuredArtists,
        explicitContent,
        playCount,
        language,
        url,
        image,
      ];

  @override
  PlayableMediaType get itemType => PlayableMediaType.song;

  @override
  String? get artworkUrl => image?.lastOrNull?.link;
}
