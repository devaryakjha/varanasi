// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playable_item_impl.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayableMediaImplAdapter extends TypeAdapter<PlayableMediaImpl> {
  @override
  final int typeId = 24;

  @override
  PlayableMediaImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayableMediaImpl(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayableMediaImpl obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._itemId)
      ..writeByte(1)
      ..write(obj._itemTitle)
      ..writeByte(2)
      ..write(obj._itemSubtitle)
      ..writeByte(3)
      ..write(obj._itemUrl)
      ..writeByte(4)
      ..write(obj._itemType)
      ..writeByte(5)
      ..write(obj._artworkUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayableMediaImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
