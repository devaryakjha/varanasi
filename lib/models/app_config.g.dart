// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppConfigAdapter extends TypeAdapter<AppConfig> {
  @override
  final int typeId = 13;

  @override
  AppConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfig(
      sortBy: fields[0] == null ? SortBy.custom : fields[0] as SortBy,
      repeatMode: fields[1] == null ? 0 : fields[1] as int,
      colorScheme: fields[2] == null ? 41 : fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sortBy)
      ..writeByte(1)
      ..write(obj.repeatMode)
      ..writeByte(2)
      ..write(obj.colorScheme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
