// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadUrlAdapter extends TypeAdapter<DownloadUrl> {
  @override
  final int typeId = 10;

  @override
  DownloadUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadUrl(
      quality: fields[0] as String?,
      link: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.quality)
      ..writeByte(1)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DownloadQualityAdapter extends TypeAdapter<DownloadQuality> {
  @override
  final int typeId = 16;

  @override
  DownloadQuality read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DownloadQuality.low;
      case 1:
        return DownloadQuality.medium;
      case 2:
        return DownloadQuality.high;
      case 3:
        return DownloadQuality.veryHigh;
      case 4:
        return DownloadQuality.extreme;
      default:
        return DownloadQuality.low;
    }
  }

  @override
  void write(BinaryWriter writer, DownloadQuality obj) {
    switch (obj) {
      case DownloadQuality.low:
        writer.writeByte(0);
        break;
      case DownloadQuality.medium:
        writer.writeByte(1);
        break;
      case DownloadQuality.high:
        writer.writeByte(2);
        break;
      case DownloadQuality.veryHigh:
        writer.writeByte(3);
        break;
      case DownloadQuality.extreme:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadQualityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadUrl _$DownloadUrlFromJson(Map<String, dynamic> json) => DownloadUrl(
      quality: json['quality'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$DownloadUrlToJson(DownloadUrl instance) =>
    <String, dynamic>{
      'quality': instance.quality,
      'link': instance.link,
    };
