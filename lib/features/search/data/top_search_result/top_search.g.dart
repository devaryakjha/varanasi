// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSearch _$TopSearchFromJson(Map<String, dynamic> json) => TopSearch(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
      type: json['type'] as String?,
      album: json['album'] as String?,
    );

Map<String, dynamic> _$TopSearchToJson(TopSearch instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'url': instance.url,
      'type': instance.type,
      'album': instance.album,
    };
