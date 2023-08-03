import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'album.dart';
import 'chart.dart';
import 'playlist.dart';
import 'trending.dart';

part 'home_page_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ModulesResponse extends Equatable {
  @HiveField(0)
  final List<Album>? albums;
  @HiveField(1)
  final List<Playlist>? playlists;
  @HiveField(2)
  final List<Chart>? charts;
  @HiveField(3)
  final Trending? trending;

  const ModulesResponse({
    this.albums,
    this.playlists,
    this.charts,
    this.trending,
  });

  factory ModulesResponse.fromJson(Map<String, dynamic> json) {
    return _$HomePageDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomePageDataToJson(this);

  ModulesResponse copyWith({
    List<Album>? albums,
    List<Playlist>? playlists,
    List<Chart>? charts,
    Trending? trending,
  }) {
    return ModulesResponse(
      albums: albums ?? this.albums,
      playlists: playlists ?? this.playlists,
      charts: charts ?? this.charts,
      trending: trending ?? this.trending,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [albums, playlists, charts, trending];
}
