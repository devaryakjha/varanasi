import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/playable_item.dart';
import 'package:varanasi_mobile_app/utils/extensions/extensions.dart';

import 'album.dart';
import 'artist.dart';
import 'download_url.dart';
import 'image.dart';

part 'song.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 12)
class Song extends PlayableMedia {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final Album? album;
  @HiveField(3)
  final String? year;
  @HiveField(4)
  final String? releaseDate;
  @HiveField(5)
  final String? duration;
  @HiveField(6)
  final String? label;
  @HiveField(7)
  final List<Artist>? primaryArtists;
  @HiveField(8)
  final String? primaryArtistsId;
  @HiveField(9)
  final List<Artist>? featuredArtists;
  @HiveField(10)
  final String? featuredArtistsId;
  @HiveField(11)
  final String? explicitContent;
  @HiveField(12)
  final String? playCount;
  @HiveField(13)
  final String? language;
  @HiveField(14)
  final String? hasLyrics;
  @HiveField(15)
  final String? url;
  @HiveField(16)
  final String? copyright;
  @HiveField(17)
  final List<Image>? image;
  @HiveField(18)
  final List<DownloadUrl>? downloadUrl;
  @HiveField(19)
  final String? description;

  const Song({
    this.id,
    this.name,
    this.album,
    this.year,
    this.releaseDate,
    this.duration,
    this.label,
    this.primaryArtists,
    this.primaryArtistsId,
    this.featuredArtists,
    this.featuredArtistsId,
    this.explicitContent,
    this.playCount,
    this.language,
    this.hasLyrics,
    this.url,
    this.copyright,
    this.image,
    this.downloadUrl,
    this.description,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SongToJson(this);

  Song copyWith({
    String? id,
    String? name,
    Album? album,
    String? year,
    String? releaseDate,
    String? duration,
    String? label,
    List<Artist>? primaryArtists,
    String? primaryArtistsId,
    List<Artist>? featuredArtists,
    String? featuredArtistsId,
    String? explicitContent,
    String? playCount,
    String? language,
    String? hasLyrics,
    String? url,
    String? copyright,
    List<Image>? image,
    List<DownloadUrl>? downloadUrl,
    String? description,
  }) {
    return Song(
      id: id ?? this.id,
      name: name ?? this.name,
      album: album ?? this.album,
      year: year ?? this.year,
      releaseDate: releaseDate ?? this.releaseDate,
      duration: duration ?? this.duration,
      label: label ?? this.label,
      primaryArtists: primaryArtists ?? this.primaryArtists,
      primaryArtistsId: primaryArtistsId ?? this.primaryArtistsId,
      featuredArtists: featuredArtists ?? this.featuredArtists,
      featuredArtistsId: featuredArtistsId ?? this.featuredArtistsId,
      explicitContent: explicitContent ?? this.explicitContent,
      playCount: playCount ?? this.playCount,
      language: language ?? this.language,
      hasLyrics: hasLyrics ?? this.hasLyrics,
      url: url ?? this.url,
      copyright: copyright ?? this.copyright,
      image: image ?? this.image,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      description: description ?? this.description,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      album,
      year,
      releaseDate,
      duration,
      label,
      primaryArtists,
      primaryArtistsId,
      featuredArtists,
      featuredArtistsId,
      explicitContent,
      playCount,
      language,
      hasLyrics,
      url,
      copyright,
      image,
      downloadUrl,
      description,
    ];
  }

  @override
  PlayableMediaType get itemType => PlayableMediaType.song;

  @override
  String? get artworkUrl => image?.lastOrNull?.link;

  @override
  String get itemId => id ?? '';

  @override
  String get itemSubtitle => (description ?? '').sanitize;

  @override
  String get itemTitle => (name ?? '').sanitize;

  @override
  String get itemUrl => downloadUrl?.lastOrNull?.link ?? '';
}
