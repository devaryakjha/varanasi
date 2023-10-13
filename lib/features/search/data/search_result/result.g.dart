// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as String?,
      title: json['title'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: json['album'] as String?,
      url: json['url'] as String?,
      type: json['type'] as String?,
      language: json['language'] as String?,
      description: json['description'] as String?,
      position: json['position'] as int?,
      primaryArtists: json['primaryArtists'] as String?,
      singers: json['singers'] as String?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image?.map((e) => e.toJson()).toList(),
      'album': instance.album,
      'url': instance.url,
      'type': instance.type,
      'language': instance.language,
      'description': instance.description,
      'position': instance.position,
      'primaryArtists': instance.primaryArtists,
      'singers': instance.singers,
    };
