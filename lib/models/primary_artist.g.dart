// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primary_artist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrimaryArtistAdapter extends TypeAdapter<PrimaryArtist> {
  @override
  final int typeId = 2;

  @override
  PrimaryArtist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrimaryArtist(
      id: fields[0] as String?,
      name: fields[1] as String?,
      url: fields[2] as String?,
      image: (fields[3] as List?)?.cast<Image>(),
      type: fields[4] as String?,
      role: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PrimaryArtist obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.role);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimaryArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrimaryArtist _$PrimaryArtistFromJson(Map<String, dynamic> json) =>
    PrimaryArtist(
      id: json['id'] as String?,
      name: json['name'] as String?,
      url: json['url'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$PrimaryArtistToJson(PrimaryArtist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'image': instance.image,
      'type': instance.type,
      'role': instance.role,
    };
