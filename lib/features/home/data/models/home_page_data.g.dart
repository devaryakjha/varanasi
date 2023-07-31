// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomePageDataAdapter extends TypeAdapter<HomePageData> {
  @override
  final int typeId = 0;

  @override
  HomePageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomePageData(
      albums: (fields[0] as List?)?.cast<Album>(),
      playlists: (fields[1] as List?)?.cast<Playlist>(),
      charts: (fields[2] as List?)?.cast<Chart>(),
      trending: fields[3] as Trending?,
    );
  }

  @override
  void write(BinaryWriter writer, HomePageData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.albums)
      ..writeByte(1)
      ..write(obj.playlists)
      ..writeByte(2)
      ..write(obj.charts)
      ..writeByte(3)
      ..write(obj.trending);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomePageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageData _$HomePageDataFromJson(Map<String, dynamic> json) => HomePageData(
      albums: (json['albums'] as List<dynamic>?)
          ?.map((e) => Album.fromJson(e as Map<String, dynamic>))
          .toList(),
      playlists: (json['playlists'] as List<dynamic>?)
          ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
          .toList(),
      charts: (json['charts'] as List<dynamic>?)
          ?.map((e) => Chart.fromJson(e as Map<String, dynamic>))
          .toList(),
      trending: json['trending'] == null
          ? null
          : Trending.fromJson(json['trending'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomePageDataToJson(HomePageData instance) =>
    <String, dynamic>{
      'albums': instance.albums,
      'playlists': instance.playlists,
      'charts': instance.charts,
      'trending': instance.trending,
    };
