// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Songs _$SongsFromJson(Map<String, dynamic> json) => Songs(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as int?,
    );

Map<String, dynamic> _$SongsToJson(Songs instance) => <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'position': instance.position,
    };
