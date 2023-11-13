// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllSearchResult _$AllSearchResultFromJson(Map<String, dynamic> json) =>
    AllSearchResult(
      topQuery: json['topQuery'] == null
          ? null
          : TopQuery.fromJson(json['topQuery'] as Map<String, dynamic>),
      songs: json['songs'] == null
          ? null
          : Songs.fromJson(json['songs'] as Map<String, dynamic>),
      albums: json['albums'] == null
          ? null
          : Albums.fromJson(json['albums'] as Map<String, dynamic>),
      artists: json['artists'] == null
          ? null
          : Artists.fromJson(json['artists'] as Map<String, dynamic>),
      playlists: json['playlists'] == null
          ? null
          : Playlists.fromJson(json['playlists'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllSearchResultToJson(AllSearchResult instance) =>
    <String, dynamic>{
      'topQuery': instance.topQuery?.toJson(),
      'songs': instance.songs?.toJson(),
      'albums': instance.albums?.toJson(),
      'artists': instance.artists?.toJson(),
      'playlists': instance.playlists?.toJson(),
    };

SongSearchResult _$SongSearchResultFromJson(Map<String, dynamic> json) =>
    SongSearchResult(
      total: json['total'] as int?,
      start: json['start'] as int?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongSearchResultToJson(SongSearchResult instance) =>
    <String, dynamic>{
      'total': instance.total,
      'start': instance.start,
      'results': instance.results?.map((e) => e.toJson()).toList(),
    };
