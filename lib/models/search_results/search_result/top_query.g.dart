// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopQuery _$TopQueryFromJson(Map<String, dynamic> json) => TopQuery(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
      position: json['position'] as int?,
    );

Map<String, dynamic> _$TopQueryToJson(TopQuery instance) => <String, dynamic>{
      'results': instance.results?.map((e) => e.toJson()).toList(),
      'position': instance.position,
    };
