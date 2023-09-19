// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SortByAdapter extends TypeAdapter<SortBy> {
  @override
  final int typeId = 14;

  @override
  SortBy read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SortBy.custom;
      case 1:
        return SortBy.title;
      default:
        return SortBy.custom;
    }
  }

  @override
  void write(BinaryWriter writer, SortBy obj) {
    switch (obj) {
      case SortBy.custom:
        writer.writeByte(0);
        break;
      case SortBy.title:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SortByAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
