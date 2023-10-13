// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as int?,
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'position': instance.position,
    };
