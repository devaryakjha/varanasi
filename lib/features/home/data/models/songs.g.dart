// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongAdapter extends TypeAdapter<Song> {
  @override
  final int typeId = 8;

  @override
  Song read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Song(
      id: fields[0] as String?,
      name: fields[1] as String?,
      type: fields[2] as String?,
      album: fields[3] as Album?,
      year: fields[4] as String?,
      releaseDate: fields[5] as String?,
      duration: fields[6] as String?,
      label: fields[7] as String?,
      primaryArtists: (fields[8] as List?)?.cast<PrimaryArtist>(),
      featuredArtists: (fields[9] as List?)?.cast<dynamic>(),
      explicitContent: fields[10] as String?,
      playCount: fields[11] as String?,
      language: fields[12] as String?,
      url: fields[13] as String?,
      image: (fields[14] as List?)?.cast<Image>(),
    );
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.releaseDate)
      ..writeByte(6)
      ..write(obj.duration)
      ..writeByte(7)
      ..write(obj.label)
      ..writeByte(8)
      ..write(obj.primaryArtists)
      ..writeByte(9)
      ..write(obj.featuredArtists)
      ..writeByte(10)
      ..write(obj.explicitContent)
      ..writeByte(11)
      ..write(obj.playCount)
      ..writeByte(12)
      ..write(obj.language)
      ..writeByte(13)
      ..write(obj.url)
      ..writeByte(14)
      ..write(obj.image);
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
      type: json['type'] as String?,
      album: json['album'] == null
          ? null
          : Album.fromJson(json['album'] as Map<String, dynamic>),
      year: json['year'] as String?,
      releaseDate: json['releaseDate'] as String?,
      duration: json['duration'] as String?,
      label: json['label'] as String?,
      primaryArtists: (json['primaryArtists'] as List<dynamic>?)
          ?.map((e) => PrimaryArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredArtists: json['featuredArtists'] as List<dynamic>?,
      explicitContent: json['explicitContent'] as String?,
      playCount: json['playCount'] as String?,
      language: json['language'] as String?,
      url: json['url'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'album': instance.album,
      'year': instance.year,
      'releaseDate': instance.releaseDate,
      'duration': instance.duration,
      'label': instance.label,
      'primaryArtists': instance.primaryArtists,
      'featuredArtists': instance.featuredArtists,
      'explicitContent': instance.explicitContent,
      'playCount': instance.playCount,
      'language': instance.language,
      'url': instance.url,
      'image': instance.image,
    };
