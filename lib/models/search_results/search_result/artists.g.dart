// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artists _$ArtistsFromJson(Map<String, dynamic> json) => Artists(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as int?,
    );

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'position': instance.position,
    };
