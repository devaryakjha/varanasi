// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrendingAdapter extends TypeAdapter<Trending> {
  @override
  final int typeId = 7;

  @override
  Trending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trending(
      songs: (fields[0] as List?)?.cast<Song>(),
      albums: (fields[1] as List?)?.cast<Album>(),
    );
  }

  @override
  void write(BinaryWriter writer, Trending obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.songs)
      ..writeByte(1)
      ..write(obj.albums);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trending _$TrendingFromJson(Map<String, dynamic> json) => Trending(
      songs: (json['songs'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrendingToJson(Trending instance) => <String, dynamic>{
      'songs': instance.songs,
      'albums': instance.albums,
    };
