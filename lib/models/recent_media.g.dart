// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_media.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentMediaAdapter extends TypeAdapter<RecentMedia> {
  @override
  final int typeId = 23;

  @override
  RecentMedia read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentMedia(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as UserLibrary?,
      fields[3] as PlayableMedia?,
    );
  }

  @override
  void write(BinaryWriter writer, RecentMedia obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj._itemId)
      ..writeByte(1)
      ..write(obj.lastPlayed)
      ..writeByte(2)
      ..write(obj.sourceLibrary)
      ..writeByte(3)
      ..write(obj.sourceMedia);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentMediaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
