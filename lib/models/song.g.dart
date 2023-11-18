// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 12;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      id: fields[0] as String?,
      name: fields[1] as String?,
      album: fields[2] as Album?,
      year: fields[3] as String?,
      releaseDate: fields[4] as String?,
      duration: fields[5] as String?,
      label: fields[6] as String?,
      primaryArtists: (fields[7] as List?)?.cast<Artist>(),
      primaryArtistsId: fields[8] as String?,
      featuredArtists: (fields[9] as List?)?.cast<Artist>(),
      featuredArtistsId: fields[10] as String?,
      explicitContent: fields[11] as String?,
      playCount: fields[12] as String?,
      language: fields[13] as String?,
      hasLyrics: fields[14] as String?,
      url: fields[15] as String?,
      copyright: fields[16] as String?,
      image: (fields[17] as List?)?.cast<Image>(),
      downloadUrl: (fields[18] as List?)?.cast<DownloadUrl>(),
      description: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.album)
      ..writeByte(3)
      ..write(obj.year)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.label)
      ..writeByte(7)
      ..write(obj.primaryArtists)
      ..writeByte(8)
      ..write(obj.primaryArtistsId)
      ..writeByte(9)
      ..write(obj.featuredArtists)
      ..writeByte(10)
      ..write(obj.featuredArtistsId)
      ..writeByte(11)
      ..write(obj.explicitContent)
      ..writeByte(12)
      ..write(obj.playCount)
      ..writeByte(13)
      ..write(obj.language)
      ..writeByte(14)
      ..write(obj.hasLyrics)
      ..writeByte(15)
      ..write(obj.url)
      ..writeByte(16)
      ..write(obj.copyright)
      ..writeByte(17)
      ..write(obj.image)
      ..writeByte(18)
      ..write(obj.downloadUrl)
      ..writeByte(19)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      id: json['id'] as String?,
      name: json['name'] as String?,
      album: json['album'] == null
          ? null
          : Album.fromJson(json['album'] as Map<String, dynamic>),
      year: json['year'] as String?,
      releaseDate: json['releaseDate'] as String?,
      duration: json['duration'] as String?,
      label: json['label'] as String?,
      primaryArtists: (json['primaryArtists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      primaryArtistsId: json['primaryArtistsId'] as String?,
      featuredArtists: (json['featuredArtists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredArtistsId: json['featuredArtistsId'] as String?,
      explicitContent: json['explicitContent'] as String?,
      playCount: json['playCount'] as String?,
      language: json['language'] as String?,
      hasLyrics: json['hasLyrics'] as String?,
      url: json['url'] as String?,
      copyright: json['copyright'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      downloadUrl: (json['downloadUrl'] as List<dynamic>?)
          ?.map((e) => DownloadUrl.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'album': instance.album?.toJson(),
      'year': instance.year,
      'releaseDate': instance.releaseDate,
      'duration': instance.duration,
      'label': instance.label,
      'primaryArtists':
          instance.primaryArtists?.map((e) => e.toJson()).toList(),
      'primaryArtistsId': instance.primaryArtistsId,
      'featuredArtists':
          instance.featuredArtists?.map((e) => e.toJson()).toList(),
      'featuredArtistsId': instance.featuredArtistsId,
      'explicitContent': instance.explicitContent,
      'playCount': instance.playCount,
      'language': instance.language,
      'hasLyrics': instance.hasLyrics,
      'url': instance.url,
      'copyright': instance.copyright,
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'downloadUrl': instance.downloadUrl?.map((e) => e.toJson()).toList(),
      'description': instance.description,
    };
