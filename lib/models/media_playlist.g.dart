// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_playlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaPlaylistAdapter<T extends PlayableMedia>
    extends TypeAdapter<MediaPlaylist<T>> {
  @override
  final int typeId = 15;

  @override
  MediaPlaylist<T> read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaPlaylist(
      id: (fields[0] as String?) ?? '',
      title: fields[1] as String?,
      description: fields[2] as String?,
      mediaItems: (fields[3] as List?)?.cast<T>(),
      images: (fields[4] as List).cast<Image>(),
      url: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MediaPlaylist obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.mediaItems)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaPlaylistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
