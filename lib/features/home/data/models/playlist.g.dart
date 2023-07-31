// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistAdapter extends TypeAdapter<Playlist> {
  @override
  final int typeId = 5;

  @override
  Playlist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlist(
      id: fields[0] as String?,
      userId: fields[1] as String?,
      title: fields[2] as String?,
      subtitle: fields[3] as String?,
      type: fields[4] as String?,
      image: (fields[5] as List?)?.cast<Image>(),
      url: fields[6] as String?,
      songCount: fields[7] as String?,
      firstname: fields[8] as String?,
      followerCount: fields[9] as String?,
      lastUpdated: fields[10] as String?,
      explicitContent: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Playlist obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.subtitle)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.url)
      ..writeByte(7)
      ..write(obj.songCount)
      ..writeByte(8)
      ..write(obj.firstname)
      ..writeByte(9)
      ..write(obj.followerCount)
      ..writeByte(10)
      ..write(obj.lastUpdated)
      ..writeByte(11)
      ..write(obj.explicitContent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      type: json['type'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
      songCount: json['songCount'] as String?,
      firstname: json['firstname'] as String?,
      followerCount: json['followerCount'] as String?,
      lastUpdated: json['lastUpdated'] as String?,
      explicitContent: json['explicitContent'] as String?,
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'type': instance.type,
      'image': instance.image,
      'url': instance.url,
      'songCount': instance.songCount,
      'firstname': instance.firstname,
      'followerCount': instance.followerCount,
      'lastUpdated': instance.lastUpdated,
      'explicitContent': instance.explicitContent,
    };
