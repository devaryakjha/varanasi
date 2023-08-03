// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChartAdapter extends TypeAdapter<Chart> {
  @override
  final int typeId = 6;

  @override
  Chart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chart(
      id: fields[0] as String?,
      title: fields[1] as String?,
      subtitle: fields[2] as String?,
      type: fields[3] as String?,
      image: (fields[4] as List?)?.cast<Image>(),
      url: fields[5] as String?,
      firstname: fields[6] as String?,
      explicitContent: fields[7] as String?,
      language: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Chart obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.firstname)
      ..writeByte(7)
      ..write(obj.explicitContent)
      ..writeByte(8)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chart _$ChartFromJson(Map<String, dynamic> json) => Chart(
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      type: json['type'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
      firstname: json['firstname'] as String?,
      explicitContent: json['explicitContent'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$ChartToJson(Chart instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'type': instance.type,
      'image': instance.image,
      'url': instance.url,
      'firstname': instance.firstname,
      'explicitContent': instance.explicitContent,
      'language': instance.language,
    };
