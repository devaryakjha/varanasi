// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadedMediaAdapter extends TypeAdapter<DownloadedMedia> {
  @override
  final int typeId = 17;

  @override
  DownloadedMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadedMedia(
      id: fields[0] as String,
      media: fields[1] as Song,
      path: fields[2] as String,
      progress: fields[3] as double,
      downloadComplete: fields[4] as bool,
      downloading: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadedMedia obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.media)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.progress)
      ..writeByte(4)
      ..write(obj.downloadComplete)
      ..writeByte(5)
      ..write(obj.downloading);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadedMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
