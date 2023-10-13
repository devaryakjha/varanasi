// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
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

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'topQuery': instance.topQuery?.toJson(),
      'songs': instance.songs?.toJson(),
      'albums': instance.albums?.toJson(),
      'artists': instance.artists?.toJson(),
      'playlists': instance.playlists?.toJson(),
    };
