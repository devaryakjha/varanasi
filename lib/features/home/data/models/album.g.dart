// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 1;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(
      id: fields[0] as String?,
      name: fields[1] as String?,
      year: fields[2] as String?,
      type: fields[3] as String?,
      playCount: fields[4] as String?,
      language: fields[5] as String?,
      explicitContent: fields[6] as String?,
      url: fields[7] as String?,
      primaryArtists: (fields[8] as List?)?.cast<PrimaryArtist>(),
      featuredArtists: (fields[9] as List?)?.cast<dynamic>(),
      artists: (fields[10] as List?)?.cast<Artist>(),
      image: (fields[11] as List?)?.cast<Image>(),
      songs: (fields[12] as List?)?.cast<dynamic>(),
      songCount: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.year)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.playCount)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.explicitContent)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.primaryArtists)
      ..writeByte(9)
      ..write(obj.featuredArtists)
      ..writeByte(10)
      ..write(obj.artists)
      ..writeByte(11)
      ..write(obj.image)
      ..writeByte(12)
      ..write(obj.songs)
      ..writeByte(13)
      ..write(obj.songCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      id: json['id'] as String?,
      name: json['name'] as String?,
      year: json['year'] as String?,
      type: json['type'] as String?,
      playCount: json['playCount'] as String?,
      language: json['language'] as String?,
      explicitContent: json['explicitContent'] as String?,
      url: json['url'] as String?,
      primaryArtists: (json['primaryArtists'] as List<dynamic>?)
          ?.map((e) => PrimaryArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredArtists: json['featuredArtists'] as List<dynamic>?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      songs: json['songs'] as List<dynamic>?,
      songCount: json['songCount'] as String?,
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'year': instance.year,
      'type': instance.type,
      'playCount': instance.playCount,
      'language': instance.language,
      'explicitContent': instance.explicitContent,
      'url': instance.url,
      'primaryArtists': instance.primaryArtists,
      'featuredArtists': instance.featuredArtists,
      'artists': instance.artists,
      'image': instance.image,
      'songs': instance.songs,
      'songCount': instance.songCount,
    };
