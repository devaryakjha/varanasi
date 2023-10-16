// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopSearchResult _$TopSearchResultFromJson(Map<String, dynamic> json) =>
    TopSearchResult(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TopSearch.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'],
    );

Map<String, dynamic> _$TopSearchResultToJson(TopSearchResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'error': instance.error,
    };
