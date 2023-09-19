import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:varanasi_mobile_app/models/album.dart';
import 'package:varanasi_mobile_app/models/playlist.dart';

import 'chart.dart';
import 'trending.dart';

part 'home_page_data.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class HomePageData extends Equatable {
  @HiveField(0)
  final List<Album>? albums;
  @HiveField(1)
  final List<Playlist>? playlists;
  @HiveField(2)
  final List<Chart>? charts;
  @HiveField(3)
  final Trending? trending;

  const HomePageData({
    this.albums,
    this.playlists,
    this.charts,
    this.trending,
  });

  factory HomePageData.fromJson(Map<String, dynamic> json) {
    return _$HomePageDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomePageDataToJson(this);

  HomePageData copyWith({
    List<Album>? albums,
    List<Playlist>? playlists,
    List<Chart>? charts,
    Trending? trending,
  }) {
    return HomePageData(
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
