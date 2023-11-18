// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_library.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLibraryAdapter extends TypeAdapter<UserLibrary> {
  @override
  final int typeId = 18;

  @override
  UserLibrary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLibrary(
      id: fields[1] as String,
      title: fields[2] as String?,
      description: fields[3] as String?,
      mediaItems: fields[4] == null ? [] : (fields[4] as List).cast<Song>(),
      images: fields[5] == null ? [] : (fields[5] as List).cast<Image>(),
      type: fields[0] as UserLibraryType,
    );
  }

  @override
  void write(BinaryWriter writer, UserLibrary obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.mediaItems)
      ..writeByte(5)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLibraryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserLibraryTypeAdapter extends TypeAdapter<UserLibraryType> {
  @override
  final int typeId = 22;

  @override
  UserLibraryType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserLibraryType.favorite;
      case 1:
        return UserLibraryType.album;
      case 2:
        return UserLibraryType.playlist;
      case 3:
        return UserLibraryType.download;
      default:
        return UserLibraryType.favorite;
    }
  }

  @override
  void write(BinaryWriter writer, UserLibraryType obj) {
    switch (obj) {
      case UserLibraryType.favorite:
        writer.writeByte(0);
        break;
      case UserLibraryType.album:
        writer.writeByte(1);
        break;
      case UserLibraryType.playlist:
        writer.writeByte(2);
        break;
      case UserLibraryType.download:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLibraryTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
